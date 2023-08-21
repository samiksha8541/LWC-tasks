import { LightningElement,track} from 'lwc';

export default class ConditionalRenderingFalse extends LightningElement {
    @track hideText = false;
  hideHandler() {
    this.hideText = true;
  }



}