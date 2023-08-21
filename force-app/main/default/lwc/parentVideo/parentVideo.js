import { LightningElement, track } from 'lwc';

export default class ParentVideo extends LightningElement {

    @track parentValue = "secondValue";
    handleEvent(){
        alert('Custom Event fired');
        this.parentValue = "thirdValue";

    }


    // handleChange(){
    //     this.parentValue = "Third Value";
    // }
}