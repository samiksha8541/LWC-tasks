import { LightningElement,track } from 'lwc';

export default class ConditionalRendering extends LightningElement {


    @track showtext = false;
    showHandler(){
        this.showtext = true;
    }
}