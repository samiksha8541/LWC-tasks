import { LightningElement, api, track } from 'lwc';
import updateContact from '@salesforce/apex/ContactEditInfo.updateContact';

export default class asyncAwaitContactInfoEdit extends LightningElement {
    @api recordId; 
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track isDisabled = true;

    connectedCallback() {
        
        this.firstName = 'John';
        this.lastName = 'Doe';
        this.email = 'john.doe@example.com';
    }

    toggleEdit() {
        this.isDisabled = !this.isDisabled;
    }

    async saveContact() {
        try {
            const updatedContact = {
                Id: this.recordId,
                FirstName: this.firstName,
                LastName: this.lastName,
                Email: this.email
            };

            await updateContact({ contact: updatedContact });

            
            this.isDisabled = true;
        } catch (error) {
            console.error('An error occurred while saving the contact:', error);
        }
    }
}
