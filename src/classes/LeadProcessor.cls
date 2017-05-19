/**
 * Created by skvarma on 2017-05-19.
 */

global with sharing class LeadProcessor implements Database.Batchable<sObject>{


    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> scopeLeads){

        for (Lead lead: scopeLeads){
            lead.LeadSource = 'Dreamforce';
        }

        update scopeLeads;
    }


    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, NumberOfErrors FROM AsyncApexJob WHERE Id = :bc.getJobId()];
//        System.debug('job Id = ' + job.Id);
//        System.debug('job Status = ' + job.Status);
//        System.debug('job JobItemsProcessed = ' + job.JobItemsProcessed);
//        System.debug('job NumberOfErrors = ' + job.NumberOfErrors);

    }




}