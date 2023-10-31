//import SwiftUI
//
//struct RootView: View {
//    @EnvironmentObject var appState: AppState
//
//    var body: some View {
//        ZStack {
//            switch appState.sceneFlow {
//            case .auth:
//                signinFactory.makeView().eraseToAnyView()
//                    .environmentObject(appState)
//
//            case .main:
//                mainTabFactory.makeView().eraseToAnyView()
//                    .environmentObject(appState)
//
//            case .splash:
//                splashFactory.makeView().eraseToAnyView()
//                    .environmentObject(appState)
//            }
//        }
//        .animation(.easeInOut, value: appState.sceneFlow)
//        .transition(.opacity.animation(.easeInOut))
//    }
//}
