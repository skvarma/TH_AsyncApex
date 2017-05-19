/**
 * Created by skvarma on 2017-05-19.
 */
@isTest
public with sharing class LeadProcessorTest {

    @testSetup
    public static void testSetup(){
        List<Lead> leads = new List<Lead>();
        for (Integer i=0;i<200;i++){
            leads.add(new Lead(firstname='Test', lastname='Lead-'+i, company='Test Company', leadSource='Test Source'));
        }
        insert leads;
    }

    @isTest
    public static void testUpdateleadSource(){

        List<Lead> leads = [SELECT Id,LeadSource FROM Lead];

        Test.startTest();
            LeadProcessor lp = new LeadProcessor();
            Id batchId = Database.executeBatch(lp);

        Test.stopTest();

        System.assertEquals(200,[SELECT count() FROM Lead WHERE LeadSource='Dreamforce'],'Lead Source not updated correctly');
    }

}