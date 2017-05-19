/**
 * Created by skvarma on 2017-05-18.
 */

public with sharing class AccountProcessor {

    @future
    public static void countContacts(Set<Id> acctIdLst){

        List<Account> acctlst = [SELECT ID, Number_of_Contacts__c, (SELECT Id from Contacts) FROM Account WHERE Id in :acctIdLst];

        for (Account acct:acctlst){
            List<Contact> contactLst = acct.Contacts;
            acct.Number_of_Contacts__c = contactLst.size();
        }
        update acctlst;
    }

}