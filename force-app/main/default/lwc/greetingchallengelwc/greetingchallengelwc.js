import { LightningElement } from 'lwc';
import Greeting from '@salesforce/label/c.Greeting';

export default class GreetingLabel extends LightningElement {
    greeting = Greeting;
}
