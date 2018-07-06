class TKModelSingleton {
    static let sharedInstance = TKModelSingleton()
    var downloadedClasses : [TKClass] = []
    var downloadedSubjects : [TKSubject] = []
    var myTKRank : TKRank?
    
    private init (){}
}
