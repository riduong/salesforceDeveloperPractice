import { LightningElement, wire, track } from 'lwc';
import getOpenCases from '@salesforce/apex/CaseController.getOpenCases';
import updateCases from '@salesforce/apex/CaseController.updateCases';
import createCase from '@salesforce/apex/CaseController.createCase';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class CaseDashboard extends LightningElement {
    @track 
    cases;
    @track 
    error;
    @track 
    draftValues = [];

    // Fields for new case creation
    newCaseSubject = '';
    newCasePriority = 'Medium';
    newCaseDescription = '';

    priorityOptions = [
        { label: 'High', value: 'High' },
        { label: 'Medium', value: 'Medium' },
        { label: 'Low', value: 'Low' }
    ];

    columns = [
        { label: 'Case Number', fieldName: 'CaseNumber', type: 'text' },
        { label: 'Subject', fieldName: 'Subject', type: 'text', editable: true },
        { label: 'Priority', fieldName: 'Priority', type: 'text', editable: true },
        { label: 'Description', fieldName: 'Description', type: 'text', editable: true }
    ];

    wiredCasesResult;

    @wire(getOpenCases)
    wiredCases(result) {
        this.wiredCasesResult = result;
        if (result.data) {
            this.cases = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.cases = undefined;
        }
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues; // List of updated rows

        updateCases({ casesToUpdate: updatedFields }) // Call Apex method
            .then(() => {
                this.showToast('Success', 'Cases updated successfully', 'success');
                return refreshApex(this.wiredCasesResult); // Refresh UI with new data
            })
            .catch(error => {
                this.showToast('Error', 'Error updating cases', 'error');
                console.error(error);
            })
            .finally(() => {
                this.draftValues = []; // Clear draft values
            });
    }

    handleSubjectChange(event) {
        this.newCaseSubject = event.target.value;
    }

    handlePriorityChange(event) {
        this.newCasePriority = event.target.value;
    }

    handleDescriptionChange(event) {
        this.newCaseDescription = event.target.value;
    }

    handleCreateCase() {
        createCase({ 
            subject: this.newCaseSubject, 
            priority: this.newCasePriority, 
            description: this.newCaseDescription 
        })
        .then(() => {
            this.showToast('Success', 'New case created successfully', 'success');
            return refreshApex(this.wiredCasesResult);
        })
        .catch(error => {
            this.showToast('Error', 'Error creating case', 'error');
            console.error(error);
        });

        this.newCaseSubject = '';
        this.newCasePriority = 'Medium';
        this.newCaseDescription = '';
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
