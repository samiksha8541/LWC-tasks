public with sharing class ContactController {
    @AuraEnabled
    public static void updateContact(String contactId, String firstName, String lastName, String email) {
        Contact contactToUpdate = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :contactId LIMIT 1];
        if (contactToUpdate != null) {
            contactToUpdate.FirstName = firstName;
            contactToUpdate.LastName = lastName;
            contactToUpdate.Email = email;
            update contactToUpdate;
        }
    }
}