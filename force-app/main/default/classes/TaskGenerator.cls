public with sharing class TaskGenerator {
    public static void handleTimeCardReminders(List<TimeCard__c> inserttimeCards) {
        List<Id> timecardsIds = new List<Id>();
        System.debug(inserttimeCards);
        for(TimeCard__c t : inserttimeCards){
            timecardsIds.add(t.Id);
        }
        generateTimecardReminders(timecardsIds);

    }
    //have to static & void & must take in Primative data types/collections
    // can't take list of sobjects 
    //@fture method is annonated and async //different set of govenor limits
    @future
    public static void generateTimecardReminders(List<Id> timecardsIds){
        List<Task> timecardReminders = new List<Task>();
        for(id i:timecardsIds){
            Task reminder= new Task();
            reminder.WhatId = i;
            reminder.Subject = 'Submit your TimeCard!';
            reminder.ActivityDate = Date.today().addDays(7);
            //reminder.CreatedDate = Date.Today().addDays(7);
            timecardReminders.add(reminder);


        }
        insert timecardReminders;
    }

}
// batch classes take large classes and also asyn, you have call explicity (maasive data set into chunks)