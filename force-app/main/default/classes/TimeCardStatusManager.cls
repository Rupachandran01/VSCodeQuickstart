public with sharing class TimeCardStatusManager {
    public TimeCardStatusManager() {

    }
    public static void updateRejectionCount(List<TimeCard__c> updatedTimeCards, 
                                                    Map<Id, TimeCard__c> oldTimecardValues){
        for(TimeCard__c t: updatedTimeCards){
            if(t.Timecard_Status__c == 'Rejected'
                    && oldTimecardValues.get(t.Id).Timecard_Status__c != 'Rejected'){
                if(t.Rejected_Count__c == null){
                    t.Rejected_Count__c = 0;
                }
                t.Rejected_Count__c = t.Rejected_Count__c + 1;
                //t.Rejected_Count__c +=1;
                // t.Rejected_Count__c ++;
            }
        }

    }
    Public static void closeRelatedTasks(List<TimeCard__c> updatedTimeCards){
        List<Id> finalizedTimecardIds = new List<Id>();
        for(TimeCard__c t: updatedTimeCards){
            if(t.Timecard_Status__c == 'Submitted'){
                finalizedTimecardIds.add(t.Id);
                
            }
        }
        List<Task> relatedTasks = [SELECT Status 
                                    FROM Task 
                                    WHERE WhatId IN :finalizedTimecardIds];
        for(Task t: relatedTasks){
            t.Status = 'Completed';
        }
        update relatedTasks;
    }
}
// don't put soql query in for loops