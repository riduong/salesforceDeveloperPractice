import { LightningElement } from 'lwc';

export default class ColorSquare extends LightningElement {

    changeColor(event) {
        const color = event.target.dataset.color;
        this.template.querySelector('.square').style.backgroundColor = color;
    }
}
