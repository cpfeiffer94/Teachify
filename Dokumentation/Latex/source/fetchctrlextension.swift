//MARK: Zugriffsschicht
extension TKFetchController{
    
    /* For Class Queries in the already fetched Model */
    func getClassIndexForName(queryName : String) -> Int{
        
        let index = model.downloadedClasses.index { (myclass) -> Bool in
            if (myclass.name == queryName){
                return true
            }
                return false
        }
        
        if let returnIndex = index {
            return returnIndex
        }
        return -1
    }
    
    /* For Subject Queries in the already fetched Model */
    func getSubjectIndexForName(queryName : String) -> Int{
        
        let index = model.downloadedSubjects.index { (mySubject) -> Bool in
            if (mySubject.name == queryName){
                return true
            }
            return false
        }
        
        if let returnIndex = index {
            return returnIndex
        }
        return -1
    }
    
    func getSubjectForIndex(index : Int) -> TKSubject {
        return model.downloadedSubjects[index]
    }
    
    
    func getClasses() -> [TKClass] {
        return model.downloadedClasses
    }
    
    func getSubjects() -> [TKSubject] {
        return model.downloadedSubjects
    }
    
    func getClassCount() -> Int {
        return model.downloadedClasses.count
    }
    
    func getSubjectCount() -> Int {
        return model.downloadedSubjects.count
    }
    
    func getDocumentCountForSubject(subjectIndex: Int) -> Int {
        return model.downloadedSubjects[subjectIndex].documents.count
    }
    
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
    
    func getClassForIndex(myIndex: Int) -> TKClass{
        return model.downloadedClasses[myIndex]
    }
    
    //    func getSubjectsForClassRecord (queryRecord : CKRecord){
    //        var postition : Int
    //
    //
    //    }
    
    func resetWithRank (newRank : TKRank){
        model.myTKRank = newRank
        model.downloadedClasses = []
        model.downloadedSubjects = []
    }
    
    func getRank() -> TKRank {
        return model.myTKRank!
    }
    
    func fetchAll(notificationName : Notification.Name? = nil, rank : TKRank) {
        resetWithRank(newRank: rank)
        
        
        let classesOperation    = ClassOperation(opRank: self.getRank())
        let subjectOperation    = SubjectOperation(opRank: self.getRank())
        let documentOperation   = DocumentOperation(opRank: self.getRank())
        let exerciseOperation   = ExerciseOperation(opRank: self.getRank())
        var subjects            = [TKSubject]()
        
        classesOperation.completionBlock = {
            subjectOperation.classes = TKModelSingleton.sharedInstance.downloadedClasses
        }
        
        subjectOperation.completionBlock = {
            if self.getRank() == TKRank.teacher {
                for element in TKModelSingleton.sharedInstance.downloadedClasses {
                    subjects.append(contentsOf: element.subjects)
                }
            }
            else if self.getRank() == TKRank.student{
                subjects = TKModelSingleton.sharedInstance.downloadedSubjects
            }
            documentOperation.subjects = subjects
            
            self.debugPrintAfterFetch()
        }
        
        documentOperation.completionBlock = {
            if self.model.myTKRank == TKRank.teacher {
                subjects = []
                for element in TKModelSingleton.sharedInstance.downloadedClasses {
                    subjects.append(contentsOf: element.subjects)
                }
            }
            else if self.model.myTKRank == TKRank.student {
                subjects = self.model.downloadedSubjects
            }
            
            for element in subjects {
                exerciseOperation.documents.append(contentsOf: element.documents)
            }
        }
        exerciseOperation.completionBlock = {
            if let notificationName = notificationName {
                print("Completion Block")
                self.debugPrintAfterFetch()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(Notification(name: notificationName))
                }
            }
        }
        //Setting Dependencies
        subjectOperation.addDependency(classesOperation)
        documentOperation.addDependency(subjectOperation)
        exerciseOperation.addDependency(documentOperation)
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations([classesOperation,subjectOperation,documentOperation,exerciseOperation], waitUntilFinished: false)
        
    }
    
    func fetchClasses(){
        let classesOperation = ClassOperation(opRank: self.getRank())
        let queue = OperationQueue()
        queue.addOperation(classesOperation)
    }
    
    func fetchSubjects(for classes : [TKClass]){
        let subjectOperation = SubjectOperation(opRank: self.getRank())
        subjectOperation.classes = classes
        let queue = OperationQueue()
        queue.addOperation(subjectOperation)
        
    }
    
    func fetchDocuments(for subjects: [TKSubject]){
        let documentOperation = DocumentOperation(opRank: self.getRank())
        documentOperation.subjects = subjects
        let queue = OperationQueue()
        queue.addOperation(documentOperation)
    }
    
    func fetchExercise(for documents: [TKDocument], notificationName: Notification.Name){
        let exerciseOperation = ExerciseOperation(opRank: self.getRank())
        exerciseOperation.documents = documents
        let queue = OperationQueue()
        queue.addOperation(exerciseOperation)
    }
    
    
}
