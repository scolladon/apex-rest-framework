/**
 * @group	Framework level
 * @description	rest_ApexRouter class defines Rest end point and delegate the call treatment to the handler
 * How to use :
POST /services/apexrest/router/v1/<handler_class_name> HTTP/1.1
Host: <instance_url>
Authorization: Bearer <access_token>
Content-Type: application/json
Accept: *\/*
Host: <instance_url>
Accept-Encoding: gzip, deflate

<body_content>
*/
@RestResource(urlMapping='/router/v1/*')
global inherited sharing class rest_ApexRouter {

    /*******************************************************************************************************
    * @description define the Post request handler. It fetch the class name, try to instanciate it and execute the treatment
    */
    @HttpPost
    global static void handleNotification() {
        try {
            RestContext.response.StatusCode = rest_HTTPStatusCodeConstants.OK;
            RestContext.response.addHeader('Content-Type', 'application/json');
            final String handlerName = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1);
            final rest_RestHandler notifHandler = (rest_RestHandler) Type.forName(handlerName).newInstance();
            notifHandler.init(RestContext.request,RestContext.response);
            notifHandler.execute();
        } catch (Exception e) {
            System.Debug(e);
            System.Debug(e.getCause());
            System.Debug(e.getMessage());
            System.Debug(e.getStackTraceString());
            final ExternalNotificationRouterRestResponse responseContent = new ExternalNotificationRouterRestResponse();
            responseContent.data = null;
            responseContent.errors.Add(new ExternalNotificationRouterRestError(e.getTypeName(), e.getMessage()));
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(responseContent));
            RestContext.response.StatusCode = rest_HTTPStatusCodeConstants.INTERNAL_SERVER_ERROR;
        }
        
    }

    /**
    * @group	Framework level
    * @description	ExternalNotificationRouterRestResponse class defines the response global envelop type
    */
    public class ExternalNotificationRouterRestResponse {
        public List<Object> data;
        public List<Object> errors;

        public ExternalNotificationRouterRestResponse(){
            this.data = new List<Object>();
            this.errors = new List<ExternalNotificationRouterRestError>();
        }
    }

    /**
    * @group	Framework level
    * @description	ExternalNotificationRouterRestError class defines the response envelop type for errors
    */
    public class ExternalNotificationRouterRestError {
        public String code;
        public String message;
        public ExternalNotificationRouterRestError(final String code, final String message) {
            this.code = code;
            this.message = message;
        }
    }
}