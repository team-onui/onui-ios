import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SettingViewModel
    @EnvironmentObject var appState: AppState
    
    init(viewModel: SettingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack(spacing: 8) {
            settingCell(text: "비속어 필터", view: {
                OnuiSwitch(isOn: $viewModel.isFiltering)
            })

            settingCell(text: "알림", view: {
                OnuiSwitch(isOn: .constant(false))
            })

            settingCell(text: "로그아웃", action: viewModel.logoutButtonDidTap)

            settingCell(text: "회원 탈퇴", action: viewModel.withdrawButtonDidTap)

            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert) {
            if viewModel.logout {
                Alert(
                    title: Text("로그아웃"),
                    message: Text("정말로 로그아웃 하시겠습니까?"),
                    primaryButton: .destructive(Text("예")) {
                        viewModel.logoutFunc()
                        viewModel.goToOnboarding = true
                    },
                    secondaryButton: .cancel(Text("취소"))
                )
            } else {
                Alert(
                    title: Text("회원탈퇴"),
                    message: Text("정말로 회원탈퇴 하시겠습니까?\n되돌릴 수 없습니다."),
                    primaryButton: .destructive(Text("예")) {
                        viewModel.withdrawFunc()
                        viewModel.goToOnboarding = true
                    },
                    secondaryButton: .cancel(Text("취소"))
                )
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Background.background)
        .onAppear(perform: viewModel.onAppear)
        .setBackButton(title: "설정") {
            dismiss()
        }
        .onChange(of: viewModel.goToOnboarding) { _ in
            dismiss()
            appState.page = .signin
        }
    }

    @ViewBuilder
    func settingCell(text: String, view: (() -> some View) = { EmptyView() }, action: @escaping () -> Void = { })-> some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)

                Spacer()

                view()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)
        }
    }
}
