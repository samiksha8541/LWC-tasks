public class MergeAndDownloadPDFController {
    @AuraEnabled
    public static List<String> getData(String accountId) {
        Map<String, String> mapOfData = new Map<String, String>();
        List<ContentDocumentLink> lsOfCDL = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :accountId];
        List<Id> tempsId = new List<Id>();
        
        for (ContentDocumentLink tempLoop : lsOfCDL) {
            tempsId.add(tempLoop.ContentDocumentId);
        }
        
        List<ContentVersion> lsOfCV = [SELECT Id, VersionData, FileExtension FROM ContentVersion WHERE ContentDocumentId = :tempsId];
        List<String> lsOfFiles = new List<String>();
        
        for (ContentVersion tempLoopCv : lsOfCV) {
            lsOfFiles.add(EncodingUtil.base64Encode(tempLoopCv.VersionData));
            
            if (String.valueOf(tempLoopCv.FileExtension).toLowerCase() == 'pdf') {
                mapOfData.put(String.valueOf(tempLoopCv.Id) + ',' + 'PDF', EncodingUtil.base64Encode(tempLoopCv.VersionData));
            } else {
                mapOfData.put(String.valueOf(tempLoopCv.Id) + ',' + 'PDF', EncodingUtil.base64Encode(tempLoopCv.VersionData));
            }
        }
        
        return lsOfFiles;
    }
}