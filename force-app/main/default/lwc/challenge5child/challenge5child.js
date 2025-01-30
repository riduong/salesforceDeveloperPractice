import { LightningElement, api } from 'lwc';

export default class Challenge5Child extends LightningElement {
    @api record;

    handleLearnMore() {
        this.dispatchEvent(new CustomEvent('learnmore', {
            detail: this.record.Id
        }));
    }
}
