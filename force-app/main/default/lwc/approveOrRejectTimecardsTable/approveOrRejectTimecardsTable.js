import { LightningElement, api } from 'lwc';

export default class ApproveOrRejectTimecardsTable extends LightningElement {
    @api timecards;
    selectedTimecard =[]; 

    columns =[
        { label: 'Name', fieldName: 'Name'},
        { label: 'Status', fieldName: 'Timecard_Status__c'},
        { label: 'Times Rejected', fieldName: 'Rejected_Count__c'}
    ];
    get isDisabled(){
        return !this.selectedTimecard.length;
        //return this.selectedTimecard.length === 0;

       /* if(this.selectedTimecard.length>0){
            return false;
        }
        return true;*/
    }
    handleRowSelection(event){
        let selectedRows = event.detail.selectedRows;
        //json.stringfy for debug
        console.log(selectedRows);
        this.selectedTimecards=selectedRows;

        
    }
    rejectdSelectedTimecards(){
        console.log('Firing event');
        let eventPayload ={
            timecards: this.selectedTimecard
        };
        const rejectTimecaardsEvent = new CustomEvent('rejecttimecards',{
            detail: eventPayload
        });
        this.dispatchEvent(rejectTimecaardsEvent);

    }
    approveSelectedTimecards(){
        let eventPayload ={
            timecards: this.selectedTimecards
        };
    }
}