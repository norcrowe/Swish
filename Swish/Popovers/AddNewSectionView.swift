import SwiftUI
import RealmSwift

struct AddNewSectionView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedResults(Section.self) private var sections
    @State private var name: String = ""
    
    // body
    var body: some View {
        VStack(spacing: 7.5) {
            TextField("Name", text: $name)
                .frame(width: 70)
                .textFieldStyle(.roundedBorder)
            
            Button("Add") {
                $sections.append(Section(name: name))
                presentationMode.wrappedValue.dismiss()
            }
            .keyboardShortcut(.defaultAction)
            .buttonStyle(BorderedButtonStyle())
            .disabled(name == "")
        }
        .padding(5)
    }
}
