//############################################
//MARK: TKFetchController
class TKFetchController: NSObject {
    fileprivate var model = TKModelSingleton.sharedInstance
    private var teacherCtrl : TKTeacherController = TKTeacherController()
    
    
    override init() {
        super.init()
    }
    
    ///    Debug Print after Data is downloaded.
    private func debugPrintAfterFetch () {
        if model.myTKRank == TKRank.student {
            print("Downloaded Subjects:")
            for (index, elementSub) in model.downloadedSubjects.enumerated() {
                print("Subject: at \(index) Name: \(elementSub.name)")
                
                print("Downloaded Documents:")
                for (index, elementDoc) in elementSub.documents.enumerated() {
                    print("Document: at \(index) Name: \(elementDoc.name)")
                    
                    print("Downloaded Exercises:")
                    for (index, elementEx) in elementDoc.exercises.enumerated() {
                        print("Exercise: at \(index) Name: \(elementEx.name)")
                        print("It works, bitches")
                }
            }
        }
    }
        else if model.myTKRank == TKRank.teacher {
            print("Downloaded Classes:")
            for (index, elementClass) in model.downloadedSubjects.enumerated() {
                print("Class: at \(index) Name: \(elementClass.name)")
                
                for (index, elementSub) in model.downloadedSubjects.enumerated() {
                    print("Subject: at \(index) Name: \(elementSub.name)")
                    
                    print("Downloaded Documents:")
                    for (index, elementDoc) in elementSub.documents.enumerated() {
                        print("Document: at \(index) Name: \(elementDoc.name)")
                        
                        print("Downloaded Exercises:")
                        for (index, elementEx) in elementDoc.exercises.enumerated() {
                            print("Exercise: at \(index) Name: \(elementEx.name)")
                            print("It works, bitches")
                            
                        }
                    }
                }
            }
        }
    }
}
