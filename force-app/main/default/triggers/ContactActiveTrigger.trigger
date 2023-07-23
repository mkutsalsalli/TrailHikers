trigger ContactActiveTrigger on Contact (after insert, after update, after delete, after undelete) {
    ContactActiveTriggerHandler.activeContacts(Trigger.new, Trigger.old, Trigger.oldMap);
    }