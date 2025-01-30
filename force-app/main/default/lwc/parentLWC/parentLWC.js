import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/CaseHelper.getAccounts';
import { refreshApex } from '@salesforce/apex';
import OBJECT_API_NAME from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';

export default class ParentLWC extends LightningElement {
    accs;
    objectApiName = OBJECT_API_NAME;
    accName = ACCOUNT_NAME;
    accAnnualRevenue = ACCOUNT_ANNUAL_REVENUE;

    @wire(getAccounts)
    wiredAccounts(result) {
        this.accs = result;
    }

    refreshCache() {
        if (this.accs) {
            refreshApex(this.accs);
        }
    }
}
