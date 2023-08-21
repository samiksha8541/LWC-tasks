import { LightningElement,wire } from 'lwc';
import { publish,MessageContext  } from 'lightning/messageService';
import Counting_Updated_Channel from '@salesforce/messageChannel/Counting_Update__c'

export default class PubLwc extends LightningElement {
    @wire(MessageContext)
    messageContext;

    handleIncrement(){
        const payload = {
            operator :'Add',
            constant : 1     



        };
        publish(this.messageContext,Counting_Updated_Channel,payload );
        


    }
    handleDecrement(){
        const payload = {
            operator :'Sub',
            constant : 1     



        }
        publish(this.messageContext,Counting_Updated_Channel,payload );


    }
    handleMultiplication(){
        const payload = {
            operator :'Multiply',
            constant : 2    



        }
        publish(this.messageContext,Counting_Updated_Channel,payload );


    }

}