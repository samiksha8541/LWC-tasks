public class LWCProductPrice {
   
    @AuraEnabled(cacheable=true)
    public static List<string> checkProduct(Id lwcRecordId){
       List<Pricebook2> priceList = [SELECT id, Name, LastModifiedById, IsActive FROM Pricebook2  ];
        List<string>  priceBookList= new List<string>();
        for(Pricebook2 pro :priceList)
        {
            priceBookList.add(pro.Name);
        }
        system.debug('==priceBookList==' +priceBookList);
        return priceBookList;
    }
      @AuraEnabled(cacheable=true)
    public static List<PricebookEntry> getRelatedrecords(string pricebookId ){
 		List<PricebookEntry> pricebookEntryList = [SELECT Pricebook2.id ,Product2.name, Product2.ProductCode, Product2.Description,Product2.Family, UnitPrice FROM PricebookEntry WHERE Pricebook2.Name = :pricebookId ];
        system.debug('pricebookEntryList' +pricebookEntryList);
           return pricebookEntryList;
    }
    @AuraEnabled(cacheable = true)
    public static list<PricebookEntry> getPricebookEntryList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
         list<PricebookEntry> PricebookEntryListRecord = new list<PricebookEntry>();
         // list<PricebookEntry> PricebookEntryListRecord =  [SELECT Pricebook2.id ,Product2.name, Product2.ProductCode, Product2.Description,Product2.Family,Quantity__c ,UnitPrice,Total_Price__c FROM PricebookEntry 
                           // WHERE name LIKE : searchKeyword];
        for(PricebookEntry PricebookEntryObj :[SELECT Pricebook2.id ,Product2.name, Product2.ProductCode, Product2.Description,Product2.Family,Quantity__c ,UnitPrice,Total_Price__c FROM PricebookEntry 
                           WHERE name LIKE : searchKeyword]){
            
           PricebookEntryListRecord.add(PricebookEntryObj);
        }
        
         if(PricebookEntryListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
        return PricebookEntryListRecord;
    }
   

}