import { LightningElement, wire, api } from 'lwc';
import getContact from '@salesforce/apex/LWCHelper.getContact';

export default class Lwc8 extends LightningElement {
    @api 
    recordId;
    contact;

    @wire(getContact, { contactId: '$recordId' })
    wiredContact({ data }) {
        if (data) {
            this.contact = data;
        }
    }
}
