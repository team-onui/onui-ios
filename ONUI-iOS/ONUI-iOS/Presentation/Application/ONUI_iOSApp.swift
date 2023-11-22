import SwiftUI
import Swinject

@main
struct ONUI_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState(page: .splash, theme: .standard)
    private let startView: any View
    
    init() {
        Roboto.registerFonts()

        _ = Assembler([
            KeychainDI(),
            DataSourceDI(),
            RepositoryDI(),
            UseCaseDI(),
            PresentationDI()
        ], container: DI.container)

        startView = DI.container.resolve(RootView.self)!
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AnyView(startView)
                    .environmentObject(appState)
            }
        }
    }
}
