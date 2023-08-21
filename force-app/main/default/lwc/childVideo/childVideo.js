import { LightningElement,api } from 'lwc';

export default class ChildVideo extends LightningElement {
    @api myName = "first Value";


    handleME(){

        const childEvent = new CustomEvent('buttonclick');
        this.dispatchEvent(childEvent);
    }
}