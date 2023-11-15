import SwiftUI
import GoogleSignIn
import Swinject

@main
struct ONUI_iOSApp: App {
    private let startView: any View
    private var assembler: Assembler!
    @StateObject var appState = AppState(page: .splash)
    
    init() {
        Roboto.registerFonts()

        assembler = Assembler([
            KeychainDI(),
            DataSourceDI(),
            RepositoryDI(),
            UseCaseDI(),
            PresentationDI()
        ], container: DI.container)

        startView = DI.container.resolve(RootView.self)!
        let config = GIDConfiguration(clientID: "797489065606-app51ou4l1ngvs2d9j0ikkom79fuateb.apps.googleusercontent.com")
                
        GIDSignIn.sharedInstance.configuration = config
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
