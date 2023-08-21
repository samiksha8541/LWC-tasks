import { LightningElement } from 'lwc';

export default class ParentToChildPArent extends LightningElement {

    startCounter = 0;


    handlestartChange(event)
    {
        this.startCounter = event.target.value;

    }



    
}