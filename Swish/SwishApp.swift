import SwiftUI
import AppKit
import Combine

@main
struct SwishApp: App {
    @AppStorage("countedSectionId") var countedSectionId: String?
    
    var body: some Scene {
        let _ = Migrator()
        
        MenuBarExtra(content: {
            MenuBarExtraContentView(countedSectionId: $countedSectionId)
                .frame(width: 300, height: 400)
        }, label: {
            MenuBarExtraLabelView(countedSectionId: $countedSectionId)
        })
        .menuBarExtraStyle(.window)
    }
}
