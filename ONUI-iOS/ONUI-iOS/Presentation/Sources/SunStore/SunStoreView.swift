import SwiftUI

struct SunStoreView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SunStoreViewModel

    init(viewModel: SunStoreViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Theme.allCases, id: \.self) { theme in
                    themeCell(theme: theme)
                }
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "햇님 방앗간") {
            dismiss()
        }
    }

    @ViewBuilder
    func themeCell(theme: Theme) -> some View {
        VStack(spacing: 8) {
            Text(theme.toKorean())
                .onuiFont(.title(.medium), color: .black)

            VStack(alignment: .trailing, spacing: 8) {
                HStack {
                    ForEach(theme.toImages().reversed(), id: \.self) { image in
                        image.frame(56)

                        if image != theme.toImages().last {
                            Spacer()
                        }
                    }
                }

                Button {
                    viewModel.changeTheme(theme: theme)
                    dismiss()
                    var themeType: ThemeType {
                        switch theme {
                        case .standard:
                            return .standard
                        case .hong:
                            return .hong
                        case .ssac:
                            return .ssac
                        case .nya:
                            return .nya
                        }
                    }
                    appState.theme = themeType.toDomain()
                } label: {
                    Text("적용하기")
                        .onuiFont(.body(.medium), color: .Primary.onPrimaryContainer)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.Primary.primaryContainer)
                        .cornerRadius(12)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)
        }
    }
}
