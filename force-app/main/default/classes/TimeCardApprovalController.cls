public with sharing class TimeCardApprovalController {

    @AuraEnabled
    public static List<TimeCard__c> getRelatedTimecards(Id projectId){
        try {
            return[ SELECT Id, Name, Timecard_Status__c,Rejected_Count__c,Submission_Date__c 
                    FROM TimeCard__c 
                    WHERE Project_Name__c =:projectId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Timecard__c createNewTimecard(Id projectId) {
        try {
            Timecard__c generatedTimecard = new Timecard__c(Project_Name__c = projectId);
            insert generatedTimecard;
            return generatedTimecard;
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void rejectTimecards(List<TimeCard__c> timecards){
        try{
            for(TimeCard__c timecard: timecards){
                Timecard_Status__c = 'Rejected';
            }
            update timecards;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());

        }
    }

    @AuraEnabled
    public static List<TimeCard__c> getRecentTimecards(Id projectId){
        try {
            return [
                SELECT Id, Name, Timecard_Status__c,Rejected_Count__c,Submission_Date__c 
                FROM TimeCard__c 
                WHERE Project_Name__c =:projectId
                AND CreatedDate = TODAY
                ];            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

