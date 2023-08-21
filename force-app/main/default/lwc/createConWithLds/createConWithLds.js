import { LightningElement,api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import NAME_FIELD from '@salesforce/schema/CON.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import ACCOUNT_NAMEFIELD from '@salesforce/schema/Contact.AccountId';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import SALUTATION_FIELD from '@salesforce/schema/Contact.Salutation';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import BIRTHDATE_FIELD from '@salesforce/schema/Contact.Birthdate';
import MAILINGCITY_FIELD from '@salesforce/schema/Contact.MailingCity';



export default class CreateConWithLds extends LightningElement {

    
    @api objectApiName;
    fields = [SALUTATION_FIELD, FIRSTNAME_FIELD, LASTNAME_FIELD, ACCOUNT_NAMEFIELD, TITLE_FIELD, PHONE_FIELD, EMAIL_FIELD, BIRTHDATE_FIELD, MAILINGCITY_FIELD];
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }




}