import SwiftUI

struct SettingsView: View {
    @AppStorage("showDealButton") var showDealButton: Bool = false
    @AppStorage("autoDealEnabled") var autoDealEnabled: Bool = true
    @AppStorage("dealingSpeed") var dealingSpeed: Double = 0.1

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Deal Button")) {
                    Toggle("Show Deal Button", isOn: $showDealButton)
                        .onChange(of: showDealButton) { newValue in
                            if !newValue {
                                autoDealEnabled = true
                            }
                        }                }
                Section(header: Text("Auto-Deal")) {
                    Toggle("Enable Auto-Deal", isOn: $autoDealEnabled)
                        .disabled(!showDealButton)
                }
                Section(header: Text("Dealing Delay")) {
                    Slider(value: $dealingSpeed, in: 0.0...0.5, step: 0.05) {
                        Text("Dealing Delay")
                    }
                    Text("\(dealingSpeed, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().preferredColorScheme(.dark)
    }
}
