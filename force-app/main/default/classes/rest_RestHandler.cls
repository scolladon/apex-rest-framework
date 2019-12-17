/**
 * @group	Framework level
 * @description	rest_RestHandler class defines the abstract types for the notification handler router. All the treatment has to extends this class properly in order to be used correctly by the framework
 */
public inherited sharing abstract class rest_RestHandler {
    /*******************************************************************************************************
    * @description this is the RestRequest received in the apex rest context
    */
    protected RestRequest req;

    /*******************************************************************************************************
    * @description this is the RestResponse set in the apex rest context
    */
    protected RestResponse res;

    /*******************************************************************************************************
    * @description this is the Object structuring the response content.
    */
    public rest_ApexRouter.ExternalNotificationRouterRestResponse responseContent;

     /*******************************************************************************************************
    * @description Object constructor, initialise the responseContent object
    */
    public rest_RestHandler() {
        this.responseContent = new rest_ApexRouter.ExternalNotificationRouterRestResponse();
    }

     /*******************************************************************************************************
    * @description Initialize the current object. Type.ForName().newInstance() do not take special constructor so the initialization has to be done after
    * @param req The contextual RestRequest
    * @param res The contextual RestResponse
    */
    public void init(final RestRequest req, final RestResponse res) {
        this.req = req;
        this.res = res;
    }

    /*******************************************************************************************************
    * @description this method has to be overriden by children classes. It is used to encapsulate the treatment (Strategy Pattern)
    */
    public abstract void execute();
}