trigger OpportunityClosedWonTrigger on Opportunity (after update) {
    OpportunityClosedWonHandler handler = new OpportunityClosedWonHandler();
    handler.afterUpdate(Trigger.new);
}
