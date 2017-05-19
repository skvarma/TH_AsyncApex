/**
 * Created by skvarma on 2017-05-18.
 */
@istest
public with sharing class AccountProcessorTest {

    @isTest
    public static void testCountContacts(){

        List<Account> acctLst = new List<Account>();
        List<Contact> conLst = new List<Contact>();
        for (Integer i=0;i<10;i++) {

            Account acct = new Account();
            acct.Name = 'Test Account - ' + i;
            acctLst.add(acct);
        }
        insert acctLst;

        for(Account acct:acctLst){

            for (Integer j=0; j<3;j++){
                Contact con = new Contact();
                con.AccountId = acct.Id;
                con.FirstName = 'Test';
                con.LastName = 'Contact -' + j;
                conLst.add(con);
            }
        }

        insert conLst;

        Set<Id> acctIds = (new Map<Id,Account>(acctLst)).keySet();

        Test.startTest();
            AccountProcessor.countContacts(acctIds);
        Test.stopTest();

        Account acctValidate = [SELECT ID, Number_of_Contacts__c, (SELECT Id from Contacts) FROM Account LIMIT 1];

        System.assertEquals(acctValidate.Number_of_Contacts__c, acctValidate.Contacts.size() ,'Invalid Number of Conatacts for this Account');
        //System.assertEquals(3,acctValidate.Number_of_Contacts__c ,'Number of Contacts not 3');
    }

}