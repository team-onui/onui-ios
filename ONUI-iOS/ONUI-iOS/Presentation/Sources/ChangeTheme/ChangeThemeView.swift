import SwiftUI

struct ChangeThemeView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ChangeThemeViewModel

    init(viewModel: ChangeThemeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.themeList, id: \.self) { theme in
                    themeCell(theme: theme)
                }
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .onAppear(perform: viewModel.onAppear)
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "햇님 방앗간") {
            dismiss()
        }
    }

    @ViewBuilder
    func themeCell(theme: Theme) -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text(theme.toKorean())
                .onuiFont(.title(.medium), color: .black)
                .frame(maxWidth: .infinity)
            
            HStack {
                ForEach(theme.toImages().reversed(), id: \.self) { image in
                    image
                        .frame(56)
                    
                    if image != theme.toImages().last {
                        Spacer()
                    }
                }
            }
            
            Button {
                viewModel.changeTheme(theme: theme) { theme in
                    appState.theme = theme
                }
            } label: {
                let isSame = viewModel.selectedTheme == theme
                Text(isSame ? "적용됨": "변경")
                    .onuiFont(.body(.medium), color: isSame ? .Primary.primary :.Primary.onPrimaryContainer)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(isSame ? .clear: Color.Primary.primaryContainer)
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.Primary.primary, lineWidth: 1)
                            .opacity(isSame ? 1: 0)
                    }
            }
            .disabled(viewModel.selectedTheme == theme)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
    }
}
