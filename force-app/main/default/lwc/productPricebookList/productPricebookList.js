import { LightningElement,wire,track } from 'lwc';
import checkProduct  from '@salesforce/apex/LWCProductPrice.checkProduct';
import getRelatedrecords from '@salesforce/apex/LWCProductPrice.getRelatedrecords';
//import getRelatedrecords from '@salesforce/apex/LWCProductPrice.getRelatedrecords';


/*const columnsdata =[{ label: 'Product Name', fieldName: 'Name' },
{ label: 'Unit Price', fieldName: 'UnitPrice', type: 'currency',editable: true},
{label: 'Quantity',fieldName:'Quantity__c',  editable: true},
{label:'Total',fieldName:'Total_Price__c'}
]*/



export default class opportunityProduct extends LightningElement {
    @track selPriceBook ;
    @track priceBookList;
    @track productList =[];
    @track showModalone = true;
    @track showModaltwo = false;
    @track showModalthree = false;
    @track nextClickComponent = false;
    

    
    
    @wire(checkProduct)
    wiredData({ error, data }) {
        debugger;
       
        if (data) {
            console.log('Data', data);
            this.priceBookList = data;
            var items = [];
            for (let key in this.priceBookList) {
                var item = {
                    "label": this.priceBookList[key],
                    "value": this.priceBookList[key]
                }
                items.push(item);
            }

            this.priceBookList =items;
        } else if (error) {
            console.error('Error:', error);
        }
    }
    handleChange(event) {
        debugger;
        
            this.selPriceBook= event.target.value;
            console.log('this.selPriceBook', this.selPriceBook)
        }
   
    nextClick(event){
        debugger;
        this.showModalone = false;
    this.showModaltwo = true;
        getRelatedrecords({pricebookId : this.selPriceBook })
        .then(result => {
                  
            this.productList =result;
        })
       .catch(error =>{
       });

}

 
PreviousClick(){
    this.showModalone = true;
    this.showModaltwo = false;
}


}