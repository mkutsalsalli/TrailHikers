@isTest
public class ContactActiveTriggerHandlerTest {
    @isTest
    static void testActiveContacts() {
        // Test data setup
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id, ActiveTeam1__c = true);
        Contact testContact2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccount.Id, ActiveTeam1__c = false);
        Contact testContact3 = new Contact(FirstName = 'David', LastName = 'Lee', AccountId = testAccount.Id, ActiveTeam1__c = true);
        List<Contact> testContacts = new List<Contact>{testContact1, testContact2, testContact3};
        insert testContacts;

        // Verify initial values
        testAccount = [SELECT Id, ActiveContactsTeam1__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(2, testAccount.ActiveContactsTeam1__c, 'Initial Active Contacts count should be 2');

        // Update a contact to set Active__c as false
        testContact1.ActiveTeam1__c = false;
        update testContact1;

        // Verify updated Active Contacts count
        testAccount = [SELECT Id, ActiveContactsTeam1__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1, testAccount.ActiveContactsTeam1__c, 'Active Contacts count should be 1 after updating a contact');

        // Delete a contact
        delete testContact3;

        // Verify updated Active Contacts count
        testAccount = [SELECT Id, ActiveContactsTeam1__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(0, testAccount.ActiveContactsTeam1__c, 'Active Contacts count should be 0 after deleting a contact');

        // Undelete a contact
        undelete testContact3;

        // Verify updated Active Contacts count
        testAccount = [SELECT Id, ActiveContactsTeam1__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1, testAccount.ActiveContactsTeam1__c, 'Active Contacts count should be 1 after undeleting a contact');
    }
}