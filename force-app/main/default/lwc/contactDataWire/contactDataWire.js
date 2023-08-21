import { LightningElement,api,wire, track} from 'lwc';
import getContactList from '@salesforce/apex/ContactListCntrl.getContactList';

export default class ContactDataWire extends LightningElement {
    // @api conlist;
    @wire (getContactList) conlist;

}