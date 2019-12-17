/**
 * @group	Framework level
 * @description	unit test class for rest_ApexRouter_Test
 */
@isTest
private class rest_ApexRouter_Test {
	private static final String TESTRESTHANDLER_CLASS_NAME = '/services/apexrest/router/v1/rest_ApexRouter_Test.TestRestHandler';

    /**
     * @description	test successful case of ther rest_ApexRouter
     */
     @isTest
    static void testSuccess() {
         RestRequest req = new RestRequest();
         RestResponse res = new RestResponse();
         req.addHeader('httpMethod', 'POST');
         req.requestUri = TESTRESTHANDLER_CLASS_NAME;
         RestContext.request = req;
         RestContext.response= res;
         Test.startTest();
         rest_ApexRouter.handleNotification();
         Test.stopTest();
         System.assertEquals(rest_HTTPStatusCodeConstants.OK,res.statusCode);
    }

    /**
     * @description	test failure case of ther rest_ApexRouter
     */
    @isTest
    static void testError() {
        RestRequest req = new RestRequest();
         RestResponse res = new RestResponse();
         req.addHeader('httpMethod', 'POST');
         req.requestUri = '/services/apexrest/router/v1/DoNotExist';
         RestContext.request = req;
         RestContext.response= res;
         Test.startTest();
         rest_ApexRouter.handleNotification();
         Test.stopTest();
         System.assertEquals(rest_HTTPStatusCodeConstants.INTERNAL_SERVER_ERROR,res.statusCode);
    }

    /**
    * @group	rest_RestHandler
    * @description	Class extending rest_RestHandler for testing purpose
    */
    public class TestRestHandler extends rest_RestHandler {
        public override void execute() {
            this.res.StatusCode = rest_HTTPStatusCodeConstants.OK;
        }
    }
}