import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    private let signinView = DI.container.resolve(SigninView.self)!
    private let mainView = DI.container.resolve(MainView.self)!

    @StateObject var viewModel: RootViewModel
    init(viewModel: RootViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ZStack {
            Color.GrayScale.Background.background
                .ignoresSafeArea(.all)

            switch appState.page {
            case .signin:
                signinView
                    .environmentObject(appState)

            case .main:
                mainView
                    .environmentObject(appState)

            case .splash:
                OnuiImage(.SplashImage)
                    .frame(128)
                    .shadow(color: .black.opacity(0.25), blur: 10)
                    .onAppear {
                        viewModel.onAppear {
                            appState.page = .main
                        } onError: { _ in
                            appState.page = .signin
                        }
                    }
            }
        }
        .animation(.easeInOut, value: appState.page)
        .transition(.slide)
    }
}
