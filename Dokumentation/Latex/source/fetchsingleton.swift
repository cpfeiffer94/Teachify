//MARK: TKModelSingleton
class TKModelSingleton {
    //TODO Zugriffsschicht
    static let sharedInstance = TKModelSingleton()
    var downloadedClasses : [TKClass] = []
    var downloadedSubjects : [TKSubject] = []
    var myTKRank : TKRank?
    
    private init (){}
}
