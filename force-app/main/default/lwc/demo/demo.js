import { LightningElement } from 'lwc';

export default class Demo extends LightningElement {

    myTitle = "Test";

    connectedCallback(){

       
        
        if(this.myTitle){
            const name = "test";

            window.alert("name"+name);

        }

        //Let Keyword

        //  if(this.myTitle){
        //     let name = "test";
        //     //window.alert("name by let"+name);


        //  }
        // window.alert("name by let"+name);

        // if(this.myTitle){

        //     const name = "testdemo";
        //     window.alert("name"+name);
        // }



       



    }



}