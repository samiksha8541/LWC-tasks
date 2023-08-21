import { LightningElement, track} from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import getAccrecords from '@salesforce/apex/createAcc.getAccrecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateAccountRecord extends LightningElement {
    @track name = NAME_FIELD;
    @track industry = INDUSTRY_FIELD;
    @track phone = PHONE_FIELD;
    rec = {
        Name : this.name,
        Industry : this.industry,
        Phone : this.phone



    }
    handleNameChange(event){
        this.rec.Name = event.target.value;


    }
    handleIndChange(event){
        this.rec.Industry = event.target.value;
    }

    handlePhnChange(event){
        this.rec.Phone = event.target.value;

    }

    handleClick(){
        getAccrecord = ({acc : this.rec})
        .then(result => {
            this.message = result;
            this.error = undefined;
            if(this.message !== undefined){
            this.rec.Name = '';
            this.rec.Industry = '';
            this.rec.Phone = '';
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'success',
                    message: 'Account created',
                    variant: 'success',
                }),
            );
            }
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            console.log("error", JSON.stringify(this.error));
        });
}
}