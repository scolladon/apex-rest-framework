/**
 * @group	Framework level
 * @description	unit test class for rest_RestHandler
 */
@isTest
private class rest_RestHandler_Test {

    /**
     * @description	test the notification handler standard behavior
     */
    @isTest
    static void testRestHandler() {
        Test.startTest();
        rest_RestHandler notifHandler = new TestRestHandler();
        final RestRequest req = new RestRequest();
        final RestResponse res = new RestResponse();
        notifHandler.init(req,res);
        notifHandler.execute();
        Test.stopTest();
        System.assertEquals(rest_HTTPStatusCodeConstants.OK,res.statusCode);
    }

    /**
    * @group	rest_RestHandler
    * @description	Class extending rest_RestHandler for testing purpose
    */
    class TestRestHandler extends rest_RestHandler {
        public override void execute() {
            this.res.StatusCode = rest_HTTPStatusCodeConstants.OK;
        }
    }
}