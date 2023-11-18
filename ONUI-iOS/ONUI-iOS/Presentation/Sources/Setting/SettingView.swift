import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SettingViewModel
    @EnvironmentObject var appState: AppState
    
    private let changeThemeView = DI.container.resolve(ChangeThemeView.self)!
    
    init(viewModel: SettingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                ZStack(alignment: .bottomTrailing) {
                    Onui(.profile, colorHex: viewModel.profile.profileTheme, frame: 70)
                        .padding(17)
                        .background(Color.GrayScale.Outline.outlineVariant)
                        .cornerRadius(12)

                    ColorPicker("", selection: $viewModel.selectedColor)
                        .frame(26)
                        .padding(4)
                }

                TextField("", text: $viewModel.profile.name, axis: .vertical)
                    .onuiFont(.body(.medium), color: .black)
                    .accentColor(.black)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Outline.outlineVariant)
                    .cornerRadius(16)

                
                Button(action: viewModel.changeProfile) {
                    Text("저장")
                        .onuiFont(.label, color: .Primary.primary)
                        .padding(.horizontal, 12.5)
                        .padding(.vertical, 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.Primary.primary, lineWidth: 1)
                        }
                }

                Spacer()

                
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)

            VStack(alignment: .trailing, spacing: 8) {
                HStack {
                    ForEach(Mood.allCases, id: \.self) { mood in
                        var moodImage: MoodImage.Image {
                            switch appState.theme {
                            case .standard:
                                return .standard(mood.moodImage())
                            case .hong:
                                return .hong(mood.moodImage())
                            case .ssac:
                                return .ssac(mood.moodImage())
                            case .nya:
                                return .nya(mood.moodImage())
                            }
                        }
                        MoodImage(
                            moodImage,
                            isOn: true
                        )
                        .frame(48)
                        
                        if mood != .veryBad {
                            Spacer()
                        }
                    }
                }

                NavigationLink(destination: changeThemeView) {
                    HStack(spacing: 5) {
                        Text("변경")
                            .onuiFont(.body(.medium), color: .Primary.onPrimaryContainer)

                        OnuiImage(.chevronRight, renderingMode: .template)
                            .frame(24)
                            .foregroundColor(.Primary.onPrimaryContainer)
                    }
                    .padding(.vertical, 4)
                    .padding(.leading, 8)
                    .background(Color.Primary.primaryContainer)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)

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
        .onuiAlert(
            isPresented: $viewModel.isShowLogout,
            title: "로그아웃",
            content: "정말로 로그아웃 하시겠습니까?"
        ) {
            viewModel.logoutFunc {
                dismiss()
                appState.page = .signin
            }
        }
        .onuiAlert(
            isPresented: $viewModel.isShowWithdraw,
            title: "회원탈퇴",
            content: "정말로 회원탈퇴 하시겠습니까?\n되돌릴 수 없습니다."
        ) {
            viewModel.withdrawFunc {
                dismiss()
                appState.page = .signin
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Background.background)
        .onAppear(perform: viewModel.onAppear)
        .setBackButton(title: "설정") {
            dismiss()
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
