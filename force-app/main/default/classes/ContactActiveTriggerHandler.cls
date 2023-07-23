public class ContactActiveTriggerHandler {
    public static void activeContacts(List<Contact> newContacts, List<Contact> oldContacts, Map<Id, Contact> oldMap) {
        Set<Id> accIds = new Set<Id>();
        //insert,update,undelete
        if (newContacts != null) {
            for (Contact contact : newContacts) {
                if (contact.ActiveTeam1__c) {
                    accIds.add(contact.AccountId);
                }
            }
        }
        //update,undelete
        if (oldContacts != null) {
            for (Contact contact : oldContacts) {
                if (contact.ActiveTeam1__c) {
                    accIds.add(contact.AccountId);
                }
            }
        }
        
        if (accIds.size() > 0) {
            List<Account> accountsToUpdate = [SELECT Id, (SELECT Id FROM Contacts WHERE ActiveTeam1__c = true) FROM Account WHERE Id IN :accIds];
            for (Account account : accountsToUpdate) {
                account.ActiveContactsTeam1__c = account.Contacts.size();
            }
            update accountsToUpdate;
        }
    }
}