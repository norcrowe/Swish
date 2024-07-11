import SwiftUI

struct AboutSwishView: View {
    let GitHubURL: URL = URL(string: "https://github.com/norcrowe/Swish")!
    let TelegramURL: URL = URL(string: "https://t.me/norcrowe")!
    let XURL: URL = URL(string: "https://x.com/norcrowe")!
    
    // body
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 0) {
                Text("Swish")
                    .font(.title)
                    .bold()
                    .italic()
                
                Image("Icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(spacing: 2.5) {
                    Group {
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)
                        
                        Text("Crated by nor")
                    }
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .italic()
                }
            }

            HStack {
                Button {
                    NSWorkspace.shared.open(GitHubURL)
                } label: {
                    Image("GitHub_Icon")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                
                Button {
                    NSWorkspace.shared.open(TelegramURL)
                } label: {
                    Image("Telegram_Icon")
                        .resizable()
                        .frame(width: 15, height: 15)
                }

                Button {
                    NSWorkspace.shared.open(XURL)
                } label: {
                    Image("X_Icon")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
            }
        }
        .padding(10)
    }
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .withinWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
    }
}
