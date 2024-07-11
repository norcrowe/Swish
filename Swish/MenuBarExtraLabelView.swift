import SwiftUI
import RealmSwift

struct MenuBarExtraLabelView: View {
    @Binding var countedSectionId: String?
    
    @ObservedResults(Section.self) private var sections
    
    private var title: String? {
        if let section = sections.first(where: {$0.id.stringValue == countedSectionId}) {
            return section.elapsedTime.formatTimeInterval
        }
        
        return nil
    }

    // body
    @ViewBuilder var body: some View {
        let image: NSImage = {
            let ratio = $0.size.height / $0.size.width
            $0.size.height = 18
            $0.size.width = 18 / ratio
            return $0
        }(NSImage(named: "Coral")!)
        
        // Icon
        Image(nsImage: image)
        
        // Title
        if let title {
            Text("\(title)")
        }
    }
}
