@isTest
private class {{ api_name }} {

    //static List<Account> testAccounts = testDataFactory.createTestRecords(new Account[10]);

    static TestMethod void {{api_name}}_UnitTest(){
        Test.startTest();

        Test.stopTest();
    }

}
