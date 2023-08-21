import { LightningElement,track } from 'lwc';

export default class LWCIFrame extends LightningElement {



    @track height = '500px';
    @track referrerPolicy = 'no-referrer';
    @track sandbox = '';
    @track url = 'https://techdicer.com/';
    @track width = '50%';
}