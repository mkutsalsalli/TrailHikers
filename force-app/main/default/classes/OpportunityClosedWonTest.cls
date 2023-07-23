@isTest
public class OpportunityClosedWonTest {
    @isTest
    static void opportunityTriggerTest01() {
        
        //Creating an Account for following Validation Rule to use it for Closed Won stage. 
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Create a test Opportunity
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            OwnerId = UserInfo.getUserId()
        );
        insert testOpportunity;

        // Update the Opportunity to 'Closed Won'
        testOpportunity.StageName = 'Closed Won';
        testOpportunity.AccountId = acc.Id;
        update testOpportunity;

        // Verify the created follow-up task
        List<Task> tasks = [SELECT Subject, OwnerId, WhatId, ActivityDate FROM Task];
        System.assertEquals(1, tasks.size());
        Task followUpTask = tasks[0];
        System.assertEquals('Follow Up Task', followUpTask.Subject);
        System.assertEquals(testOpportunity.OwnerId, followUpTask.OwnerId);
        System.assertEquals(testOpportunity.Id, followUpTask.WhatId);
        System.assertEquals(testOpportunity.CloseDate.addMonths(1), followUpTask.ActivityDate);
    }
}