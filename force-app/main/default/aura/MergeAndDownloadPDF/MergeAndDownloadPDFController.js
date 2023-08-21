({
    init: function(component, event, helper) {
        // Get the recordId from the page or pass it as needed
        var recordId = component.get("v.recordId");
        
        // Call the getData method to fetch file data
        var action = component.get("c.getData");
        action.setParams({ accountId: recordId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.docData", result);
            } else {
                console.log("Error fetching file data: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },

    mergeAndDownloadPDF: function(component, event, helper) {
        // Call the createPdf method to merge PDF files
        helper.createPdf(component);
    }
})