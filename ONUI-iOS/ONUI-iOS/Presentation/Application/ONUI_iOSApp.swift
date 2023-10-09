import SwiftUI

@main
struct ONUI_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            SigninView(viewModel: .init())
                .onAppear(perform: Roboto.registerFonts)
        }
    }
}
