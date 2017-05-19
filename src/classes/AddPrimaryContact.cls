/**
 * Created by skvarma on 2017-05-19.
 */

global class AddPrimaryContact implements Queueable{

    private Contact contact;
    private String state;

    global AddPrimaryContact(Contact contact, String state){
        this.contact = contact;
        this.state = state;
    }

    global void execute(QueueableContext context){
        List<Account> accts = [SELECT Id FROM Account where BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();

        for (Account acct:accts){
            Contact accountContact = contact.clone();
            accountContact.AccountId = acct.Id;
            contacts.add(accountContact);
        }

        insert contacts;
    }



}