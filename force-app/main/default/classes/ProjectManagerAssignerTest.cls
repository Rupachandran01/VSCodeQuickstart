 @isTest
private class ProjectManagerAssignerTest {
//methodUnderTest_given_should 

    @isTest
  static void assignTimeCardProjectManager_givenTimecard_shouldUpdateProjectManager(){
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User testUser1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');


    Project__c testProject = new Project__c();
    testProject.Name= testProject.Id;
    testProject.Project_Manager__c = testUser1.Name;
    insert testProject;

    TimeCard__c testTimeCard = new TimeCard__c();
    testTimeCard.Name = 'New Unit Test TimeCard';
    testTimeCard.Project_Name__c = testProject.Id;
    insert testTimeCard;
   
    //no accounts, database we have to create everything
   

    Test.startTest();
    //resets governor limits
    update testTimeCard;


    Test.stopTest();
    //code will wait until execution
    //assertEquals(expected, actual, msg)
    System.assertEquals(testUser1.Name, testTimeCard.Project_Manager__c, 'Project Manager Name is copied');
  
  }
}

/*
//we don't need constructor 

@isTest
private class ProjectManagerAssignerTest {
    @isTest
    static void assignTimeCardProjectManager_givenTimecard_shouldUpdateProjectManager(){
        Account testAccount = new Account(Name ='Test Account');
        insert testAccount;

        Contact testProjectManger = new Contact();
        testProjectManger.AccountId =testAccount.Id;
        testProjectManger.LastName ='John';
        insert testProjectManager;

        Project__c testProject = new Project__c();
        testProject.Name = 'Test Project';
        testProject.Project_Manager__c =testProjectManger.Id;
        //userInfo.getUserId(); -->current user data
        //contactId and userId is different 
        insert testProject;

        Test.startTest();
        TimeCard__c testTimeCard = new TimeCard__c();
        testTimeCard.Project__c = testProject.Id;
        insert testTimeCard;

        Test.stopTest();

        List<TimeCard__c> insertedTimecards = [SELECT Project_Manager__c 
                                                FROM TimeCard__c];
        system.assertEquals(testProject.Project_Manager__c, insertedTimecards[0].Project_Manager__c, 
                                                'Project Manager field is same on both');

    }

}

*/