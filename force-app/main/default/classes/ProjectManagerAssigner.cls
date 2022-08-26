public with sharing class ProjectManagerAssigner {
    public ProjectManagerAssigner() {

    }
    public static void assignTimeCardProjectManager(List<TimeCard__c> insertedTimeCards){
        List<Id> projectIds = new List<Id>();

        for(TimeCard__c t: insertedTimeCards){
            if(t.Project_Name__c != null){
                //save the project manager
                projectIds.add(t.Project_Name__c);
            }
        }
        List<Project__c> queriedProjects =[SELECT Id, Project_Manager__c
                                            FROM Project__c
                                            WHERE Id IN :projectIds];
    /*    // This is inefficient

        for(TimeCard__c t: insertedTimeCards){
            for(Project__c p: queriedProjects){
                if(t.Project_Name__c == p.Id){
                    t.Project_Manager__c = p.Project_Manager__c;
                }
            }
        } 
        //efficient 

        Map<Id, Project__c> queriedProjectsMap = new Map<Id, Project__c>();
        //queriedProjectsMap.put(key,value)
        for(Project__c p: queriedProjects){
            queriedProjectsMap.put(p.Id, p);
        }
        for(TimeCard__c t: insertedTimeCards){
            if(queriedProjectsMap.containsKey(t.Project_Name__c)){
                t.Project_Manager__c = queriedProjectsMap.get(t.Project__c).Project_Manager__c;
            }
        }
        */
        //more efficient

        Map<Id, Project__c> queriedProjectsMap = new Map<Id, Project__c>([SELECT Id, Project_Manager__c
                                                                            FROM Project__c
                                                                            WHERE Id IN :projectIds]);
        for(TimeCard__c t: insertedTimeCards){
            if(queriedProjectsMap.containsKey(t.Project_Name__c)){
                t.Project_Manager__c = queriedProjectsMap.get(t.Project_Name__c).Project_Manager__c;
            }
        }
    }
}
