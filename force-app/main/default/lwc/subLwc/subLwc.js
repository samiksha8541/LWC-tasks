import { LightningElement,wire } from 'lwc';
import { subscribe,MessageContext  } from 'lightning/messageService';
import Counting_Updated_Channel from '@salesforce/messageChannel/Counting_Update__c'

export default class SubLwc extends LightningElement {


    counter = 0;
    subscription = null;
    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscribeToMessageChannel();


    }
    subscribeToMessageChannel(){
        this.subscription = subscribe (
            this.messageContext,
            Counting_Updated_Channel,
            (message) => this.handleMessage(message)


        );
    }
    handleMessage(message){
        //alert("message : "+JSON.stringify(message));
        if(message.operator == 'add'){
            this.counter += message.constant;
        }

        else if(message.operator == 'sub'){
            this.counter -= message.constant;
        }

        else  if(message.operator == 'Multiply'){
            this.counter *= message.constant;
        }


    }


}