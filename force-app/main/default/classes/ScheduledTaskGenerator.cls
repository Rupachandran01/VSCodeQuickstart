public with sharing class ScheduledTaskGenerator implements Schedulable{
    public void execute(SchedulableContext SC){
        List<TimeCard__c> timecardsNeedingTasks = new List<TimeCard__c>();
        timecardsNeedingTasks = [SELECT Id FROM TimeCard__c
                                    WHERE CreatedDate = :Date.today().addDays(-7)];
        List<Task> generatedTasks = new List<Task>();
        for(TimeCard__c t : timecardsNeedingTasks){
            Task reminder= new Task();
            reminder.WhatId = t.Id;
            reminder.Subject = 'Submit your TimeCard!';
            reminder.ActivityDate = Date.today().addDays(1);
            //reminder.CreatedDate = Date.Today().addDays(7);
            generatedTasks.add(reminder);
        }
        insert generatedTasks;
    }
}
