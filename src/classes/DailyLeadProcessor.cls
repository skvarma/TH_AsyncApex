/**
 * Created by skvarma on 2017-05-23.
 */

global class DailyLeadProcessor implements Schedulable{

    global void execute(SchedulableContext sc){

        List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = '' LIMIT 200];

        for (Lead lead:leads){
            lead.LeadSource = 'Dreamforce';
        }

        update leads;

    }
}