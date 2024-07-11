import SwiftUI
import RealmSwift
import Combine

struct MenuBarExtraContentView: View {
    @Binding var countedSectionId: String?
    @State private var selectedSectionId: String?
    
    @ObservedResults(Section.self) private var sections
    @State private var isAddNewSectionPopoverPresented: Bool = false
    @State private var isAboutSwishPopoverPresented: Bool = false
    @State private var timer: AnyCancellable? = nil
    
    var items: [Section] {
        return self.sections.sorted(by: {
            let date1 = $0.periods.last?.end ?? $0.createdAt
            let date2 = $1.periods.last?.end ?? $1.createdAt
            
            return date1 > date2
        })
    }

    init(countedSectionId: Binding<String?>) {
        self._countedSectionId = countedSectionId
        self._selectedSectionId = State(wrappedValue: countedSectionId.wrappedValue)
    }
    
    // body
    var body: some View {
        VStack(spacing: 0) {
            List(selection: $selectedSectionId) {
                SwiftUI.Section(content: {
                    ForEach(items, id: \.id) { section in
                        // Row
                        SectionRow(section: section, countedSectionId: $countedSectionId, timer: $timer, selectedSectionId: $selectedSectionId)
                    }
                }, header: {
                    HStack {
                        Text("Sections")
                        
                        Spacer()
                        
                        // 新增章节 Button
                        Button {
                            isAddNewSectionPopoverPresented = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .keyboardShortcut("N", modifiers: .command)
                        .buttonStyle(PlainButtonStyle())
                        .popover(isPresented: $isAddNewSectionPopoverPresented, content: {
                            AddNewSectionView()
                        })
                    }
                    .padding(.horizontal, 2.5)
                })
                .collapsible(false)
                
            }
            .listStyle(.sidebar)
            
            Divider()
            
            HStack {
                Button("About Swish") {
                    isAboutSwishPopoverPresented = true
                }
                .popover(isPresented: $isAboutSwishPopoverPresented) {
                    AboutSwishView()
                }
                    
                Spacer()
                
                Button("Quit") {
                    NSApplication.shared.terminate(self)
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .padding(5)
        }
    }
}

extension MenuBarExtraContentView {
    struct SectionRow: View {
        @ObservedRealmObject var section: Section
        @Binding var countedSectionId: String?
        @Binding var timer: AnyCancellable?
        @Binding var selectedSectionId: String?

        @State private var renamedSection: Section? = nil

        // body
        var body: some View {
            HStack {
                Text(section.name)
                
                Spacer()
                
                Text(section.elapsedTime.formatTimeInterval)

                Button {
                    timerControl()
                } label: {
                    Image(systemName: countedSectionId != section.id.stringValue || timer == nil ? "play.circle" : "pause.circle")
                }
                .buttonStyle(.plain)
            }
            .tag(section.id.stringValue)
            .contextMenu {
                Button(countedSectionId != section.id.stringValue || timer == nil ? "Start" : "Pause") {
                    timerControl()
                }
                
                Button("Rename") {
                    selectedSectionId = section.id.stringValue
                    renamedSection = section
                }
                
                Button("Remove") {
                    if countedSectionId == section.id.stringValue {
                        countedSectionId = nil
                        
                        if timer != nil {
                            timer = nil
                        }
                    }
                    
                    do {
                        let realm = try Realm()
                        
                        try realm.write {
                            realm.delete(realm.objects(Section.self).filter({$0.id == section.id}))
                        }
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .popover(isPresented: Binding(get: {
                return renamedSection == section
            }, set: { value in
                renamedSection = nil
            }), content: {
                if let renamedSection {
                    RenameSectionView(section: renamedSection)
                }
            })
        }
        
        func timerControl() {
            if timer == nil || countedSectionId != section.id.stringValue {
                // 开始计时
                timer?.cancel()
                
                countedSectionId = section.id.stringValue
                
                $section.periods.append(Period())
                
                timer = Timer.publish(every: 0.1, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        $section.periods.last?.end.wrappedValue = Date()
                    }
            } else {
                // 结束计时
                timer?.cancel()
                timer = nil
            }

        }
    }
}

