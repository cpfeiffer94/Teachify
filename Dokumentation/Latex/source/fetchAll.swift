func fetchAll(notificationName : Notification.Name? = nil, rank : TKRank) {
//      1: Zuruecksetzen der des Controllers und initialisieren der Operations
        resetWithRank(newRank: rank)
        let classesOperation    = ClassOperation(opRank: self.getRank())
        let subjectOperation    = SubjectOperation(opRank: self.getRank())
        let documentOperation   = DocumentOperation(opRank: self.getRank())
        let exerciseOperation   = ExerciseOperation(opRank: self.getRank())
        var subjects            = [TKSubject]()
        
//      2: Definieren der Completion Blocks nach der Operations
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
                if exerciseOperation.isInitialized == false {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(Notification(name: notificationName))
                    }
                }
                else {
                print("Completion Block")
                self.debugPrintAfterFetch()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(Notification(name: notificationName))
                    }
                }
            }
        }
        
//      3: Setzen der Operation Dependencies und aufsetzen der Queue
        subjectOperation.addDependency(classesOperation)
        documentOperation.addDependency(subjectOperation)
        exerciseOperation.addDependency(documentOperation)
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations([classesOperation,subjectOperation,documentOperation,exerciseOperation], waitUntilFinished: false)
        
    }