import { LightningElement,api} from 'lwc';
import firstTemplate from  './lifecycleHook.html';
import secondTemplate from  './lifecycleHook2.html';

export default class LifecycleHook extends LightningElement {
    @api Templateno = 'temp1';


    constructor(){
        super();
        console.log('Inside Constructor');
    }
    connectedCallback(){
        console.log('Inside connectedCallback');
    }
    disconnectedCallback(){
        console.log('Inside disconnectedCallback');

    }
    

    changeTemplate(){
        console.log('Inside change Template');
       if(this.Templateno === 'temp1'){
        Templateno = 'temp2'


        }
        else{
            this.Templateno = 'temp1';
        }



    }
    render(){
        console.log('Inside render');
        if(this.Templateno == 'temp1')
        return firstTemplate;
        else return secondTemplate;
        
    }

    renderedCallback(){
        console.log('Inside render Callback');
    }
    errorCallback(){
        console.log('Inside Eroor Callback');
    }
}