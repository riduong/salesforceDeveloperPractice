import { LightningElement } from 'lwc';

export default class Lwc2 extends LightningElement {
    headerText = 'Default Header';
    isInputVisible = false;

    toggleInput() {
        this.isInputVisible = !this.isInputVisible;
    }

    handleInputChange(event) {
        this.headerText = event.target.value;
    }
}
