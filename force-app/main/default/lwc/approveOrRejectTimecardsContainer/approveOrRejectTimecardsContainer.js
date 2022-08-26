import { LightningElement, api } from 'lwc';
import getRelatedTimecards from '@salesforce/apex/TimeCardApprovalController.getRelatedTimecards';
import createNewTimecard from '@salesforce/apex/TimeCardApprovalController.createNewTimecard';
//import {ShowToastEvent} from 
//import 
import rejectTimecards from '@salesforce/apex/TimeCardApprovalController.rejectTimecards';

export default class ApproveOrRejectTimecardsContainer extends LightningElement {
    @api recordId;

    timecards;
    modalShown = false;

    connectedCallback(){
        getRelatedTimecards({projectId: this.recordId})
            .then(timecards => {
                console.log(timecards);
                this.timecards = timecards;
            })
            .catch(error => {
                console.warn(error);
            })
    }
    createTimecard() {
        createNewTimecard({
            projectId: this.recordId
        })
        .then(timecard => {
            console.log(timecard);
        })
        .catch(error => {
            console.warn(error);
        });
    }
    toggleModal() {
        this.modalShown = !this.modalShown;
    }
    handleSuccess(event){
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success!',
            message: 'Timecard' + event.detail.id +'created succesfully',
            variant: {labe: 'success', value:'success'} 

        }))
    }
    handleRejectTimecard(event){
        let timecardsToBeRejected = event.detail.timecards;
        console.log(timecardsToBeRejected);


        rejectTimecards({ timecards: timecardsToBeRejected})
        .then(apexResponse => {
            console.log('reject Successful');
        })
        .catch(error => {
            console.warn(error);
        });
    }
}

