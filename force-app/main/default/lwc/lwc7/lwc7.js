import { LightningElement } from 'lwc';
import searchContact from '@salesforce/apex/LWCHelper.searchContact';

export default class ApexImperativeMethod extends LightningElement {
    selectedContact;
    searchTerm = '';

    handleSearch(event) {
        this.searchTerm = event.target.value;
        
        if (this.searchTerm) {
            this.searchContactInApex(this.searchTerm);
        } else {
            this.selectedContact = null;
        }
    }

    async searchContactInApex(searchTerm) {
        const result = await searchContact({ searchTerm });

        if (result) {
            this.selectedContact = result;
        }
    }
}
