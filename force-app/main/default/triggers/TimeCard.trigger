trigger TimeCard on TimeCard__c (before update, before insert, after update, after insert) {
    //defensive program - clear a ahead time(we don't need do it here)
    if(Trigger.isBefore && Trigger.isUpdate){
        TimeCardStatusManager.updateRejectionCount(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isBefore && Trigger.isInsert){
    ProjectManagerAssigner.assignTimeCardProjectManager(Trigger.new);
    } else if (Trigger.isAfter && Trigger.isUpdate){
        TimeCardStatusManager.closeRelatedTasks(Trigger.new);
    } else if(Trigger.isAfter && Trigger.isInsert){
        TaskGenerator.handleTimeCardReminders(Trigger.new);
    }

}

//Trigger.new Trigger.old (Lists) | Trigger.oldMap Trigger.newMap (key, value pairs)
