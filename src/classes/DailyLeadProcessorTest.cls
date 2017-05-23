/**
 * Created by skvarma on 2017-05-23.
 */
@isTest
public with sharing class DailyLeadProcessorTest {

    @testSetup
    public static void setup(){

        List<Lead> leads = new List<Lead>();
        for (Integer i=0;i<200;i++){
            leads.add(new Lead(firstname='Test', lastname='Lead-'+i, company='Test Company'));
        }
        insert leads;

    }

    @isTest
    public static void testEmptyLeadSrc(){

        // Dummy CRON expression: midnight on March 15.
        // Because this is a test, job executes
        // immediately after Test.stopTest().
        String CRON_EXP = '0 0 0 15 3 ? 2022';

        Test.startTest();
            Id jobId = System.schedule('DailyLeadProcessor',CRON_EXP,new DailyLeadProcessor());
            System.assertEquals(0,[SELECT count() from Lead WHERE LeadSource='Dreamforce'],'Leads with LeadSource Already Exist');
        Test.stopTest();
        System.assertEquals(200,[SELECT count() from Lead WHERE LeadSource='Dreamforce'],'Leads with valid LeadSource do not Exist');

    }

}