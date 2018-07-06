func getSubjectAndDocumentForCollectionIndex(index : Int) -> (TKSubject,TKDocument) {
        var myindex = index
        for element in model.downloadedSubjects {
            if ((element.documents.count-1) < myindex) {
                myindex -= element.documents.count
            }
            else {
                return (element, element.documents[myindex])
            }
        }
        return (TKSubject(name: "Unknown Subject", color: TKColor.black), TKDocument(name: "nf", deadline: nil))
        
    }