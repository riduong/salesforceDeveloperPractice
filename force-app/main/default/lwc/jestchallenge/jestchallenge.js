import { LightningElement } from 'lwc';

export default class Jestchallenge extends LightningElement {
    userInput = '';
    displayText = '';

    handleInputChange(event) {
        this.userInput = event.target.value;
    }

    handleButtonClick() {
        this.displayText = this.userInput;
    }
}