import { LightningElement,api } from 'lwc';
import getAccDetails from '@salesforce/apex/getAccountDetails.getAccDetails';


export default class GetAccountData extends LightningElement {
@api records;
@api error;
handleclick(){
getAccDetails()
.then(result=>{
    this.records = result;
    this.error = undefined;

    
})

.catch(error=>{
    this.records = undefined;
    this.error = error;

    
})

}



}