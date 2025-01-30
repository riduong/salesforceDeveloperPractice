import { LightningElement, api } from 'lwc';
import deleteAccount from '@salesforce/apex/CaseHelper.deleteAccount';
import OBJECT_API_NAME from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';

export default class ChildLWC extends LightningElement {
    @api record;

    objectApiName = OBJECT_API_NAME;
    accName = ACCOUNT_NAME;
    accAnnualRevenue = ACCOUNT_ANNUAL_REVENUE;

    deleteAccount(e) {
        deleteAccount({ accountId: e.target.dataset.recordid })
            .then(() => {
                this.dispatchEvent(new CustomEvent('delete'));
            })
            .catch(error => {
                console.error('Error deleting account:', error);
            });
    }
}
