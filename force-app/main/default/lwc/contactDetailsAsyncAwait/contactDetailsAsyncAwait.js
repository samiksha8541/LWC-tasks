import { LightningElement, api, track, wire } from 'lwc';
import updateContact from '@salesforce/apex/ContactController.updateContact';


export default class ContactDetailsAsyncAwait extends LightningElement {
    @api contactId;
    @track firstName;
    @track lastName;
    @track email;
    @track isEditMode = false;

    connectedCallback() {
        // Fetch contact details based on contactId (use Apex or Lightning Data Service)
        // Sample data, replace with actual data
        this.firstName = 'John';
        this.lastName = 'Doe';
        this.email = 'john.doe@example.com';
    }

    enableEdit() {
        this.isEditMode = true;
    }

    saveContact() {
        updateContact({ contactId: this.contactId, firstName: this.firstName, lastName: this.lastName, email: this.email })
            .then(() => {
                this.isEditMode = false;
            })
            .catch(error => {
                // Handle error if needed
                console.error('An error occurred:', error);
            });
    }
}