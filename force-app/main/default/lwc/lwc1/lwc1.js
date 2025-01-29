import { LightningElement, track } from 'lwc';

export default class Lwc1 extends LightningElement {
    @track
    toDoItems = [];
    inputValue = '';

    handleInputChange(event) {
        this.inputValue = event.target.value;
    }

    handleAdd() {
        this.toDoItems.push(this.inputValue);
        this.inputValue = '';
    }
}
