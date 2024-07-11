import SwiftUI
import RealmSwift

struct RenameSectionView: View {
    @ObservedRealmObject var section: Section

    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String
    
    init(section: Section) {
        self.section = section
        self._name = State(wrappedValue: section.name)
    }
    
    // body
    var body: some View {
        VStack(spacing: 7.5) {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Button("Done") {
                    $section.name.wrappedValue = name
                    presentationMode.wrappedValue.dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name == "")
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(5)
    }
}
