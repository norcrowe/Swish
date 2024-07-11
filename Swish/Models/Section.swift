import Foundation
import RealmSwift

class Section: Object,ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var periods: RealmSwift.List<Period>
    @Persisted var createdAt: Date
    
    /// 章节总耗时
    var elapsedTime: TimeInterval {
        return periods.reduce(0) { $0 + $1.elapsedTime }
    }

    convenience init(name: String, createdAt: Date = Date(), periods: RealmSwift.List<Period> = RealmSwift.List()) {
        self.init()
        self.name = name
        self.periods = periods
        self.createdAt = createdAt
    }
}
