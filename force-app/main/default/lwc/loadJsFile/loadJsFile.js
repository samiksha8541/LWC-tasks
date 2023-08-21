// myComponent.js
import { LightningElement } from 'lwc';
import MY_JS_FILE from '@salesforce/resourceUrl/myJsFile';

export default class MyComponent extends LightningElement {
   connectedCallback() {
       super.connectedCallback();

       const script = document.createElement('script');
       script.src = MY_JS_FILE;
       this.template.appendChild(script);
   }
}