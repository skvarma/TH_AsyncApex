/**
 * Created by skvarma on 2017-05-19.
 */
@isTest
public class AddPrimaryContactTest {

    @testSetup
    public static void setup(){

        List<Account> accts = new List<Account>();
        for(Integer i=0;i<50;i++){
            accts.add(new Account(name='Test Account - ' + i,BillingState='NY'));
        }
        for(Integer i=50;i<100;i++){
            accts.add(new Account(name='Test Account - ' + i,BillingState='CA'));
        }
        insert accts;
    }

    @isTest
    public static void testAddPrimaryContact(){
        Contact contact = new Contact(firstname='Test', lastname='Contact');
        String state = 'NY';

        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(contact,state);

        Test.startTest();
            Id jobId = System.enqueueJob(AddPrimaryContact);
        Test.stopTest();

        Map<Id, Account> acctMap = new Map<Id,Account>([SELECT Id FROM Account WHERE BillingState = :state]);



        System.assertEquals(50,[SELECT count() FROM Contact WHERE AccountId in :acctMap.keySet()],'Contacts not Created');
    }

}