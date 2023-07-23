public class OpportunityClosedWonHandler {

    List<Task> taskList = new List<Task>();
   
   public void afterUpdate(List<Opportunity> newOpp) {
       for (Opportunity opp : newOpp) {
           if (opp.StageName == 'Closed Won') {
               taskList.add(new Task(
                   Subject = 'Follow Up Task',
                   OwnerId = opp.OwnerId,
                   WhatId = opp.Id,
                   ActivityDate = opp.CloseDate.addMonths(1)
               ));
           }
       }
       
       if (!taskList.isEmpty()) {
           insert taskList;
       }
   }

}