import Foundation
import RealmSwift

class Period: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var start: Date
    @Persisted var end: Date
    @Persisted(originProperty: "periods") var section: LinkingObjects<Section>

    /// 时段总耗时
    var elapsedTime: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    convenience init(start: Date = Date(), end: Date = Date()) {
        self.init()
        self.start = start
        self.end = end
    }
}
