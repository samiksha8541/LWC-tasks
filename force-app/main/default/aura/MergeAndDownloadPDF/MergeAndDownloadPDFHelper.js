({
    createPdf: function(component) {
        var docData = component.get("v.docData");
        
        if (docData.length < 1)
            return;
        
        var tempBytes = Uint8Array.from(atob(docData[0]), (c) => c.charCodeAt(0));
        var pdfDoc;
        
        PDFLib.PDFDocument.create().then(function(createdDoc) {
            pdfDoc = createdDoc;
            
            // Embed the first page
            return pdfDoc.embedPdf(tempBytes);
        }).then(function(embeddedPdf) {
            var firstPage = embeddedPdf[0];
            var americanFlagDims = firstPage.scale(0.99);
            var page = pdfDoc.addPage();
            
            page.drawPage(firstPage, {
                width: americanFlagDims.width,
                height: americanFlagDims.height,
                x: page.getWidth() - americanFlagDims.width,
                y: page.getHeight() - americanFlagDims.height - 10,
            });
            
            // Embed the rest of the pages
            if (docData.length > 1) {
                var promise = Promise.resolve();
                for (var i = 1; i < docData.length; i++) {
                    promise = promise.then(function() {
                        var tempBytes = Uint8Array.from(atob(docData[i]), (c) => c.charCodeAt(0));
                        return PDFLib.PDFDocument.load(tempBytes);
                    }).then(function(usConstitutionPdf) {
                        var preamble = usConstitutionPdf.getPages()[0];
                        var preambleDims = preamble.scale(0.95);
                        page = pdfDoc.addPage();
                        
                        page.drawPage(preamble, {
                            width: preambleDims.width,
                            height: preambleDims.height,
                            x: page.getWidth() - americanFlagDims.width,
                            y: page.getHeight() - americanFlagDims.height - 10,
                        });
                    });
                }
                
                return promise;
            }
        }).then(function() {
            // Save the merged PDF as bytes
            return pdfDoc.save();
        }).then(function(pdfBytes) {
            // Download the merged PDF
            this.saveByteArray("MergedPDF", pdfBytes);
        }).catch(function(error) {
            console.error("Error: ", error);
        });
    },

    saveByteArray: function(pdfName, byte) {
        var blob = new Blob([byte], { type: "application/pdf" });
        var link = document.createElement("a");
        link.href = window.URL.createObjectURL(blob);
        var fileName = pdfName;
        link.download = fileName;
        link.click();
    }
})