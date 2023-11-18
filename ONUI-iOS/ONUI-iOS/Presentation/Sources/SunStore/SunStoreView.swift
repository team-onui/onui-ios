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
            HStack(spacing: 8) {
                OnuiImage(.chatProfile)
                    .frame(48)

                Text("남은 쌀은 \(viewModel.rice)개에요..!!")
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Surface.surface)
                    .cornerRadius(16)

                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.top, 12)

            VStack {
                ForEach(viewModel.themeList, id: \.theme) { theme in
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
    func themeCell(theme: ThemeEntity) -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text(theme.theme.toKorean())
                .onuiFont(.title(.medium), color: .black)
                .frame(maxWidth: .infinity)
            
            HStack {
                ForEach(theme.theme.toImages().reversed(), id: \.self) { image in
                    image
                        .frame(56)
                    
                    if image != theme.theme.toImages().last {
                        Spacer()
                    }
                }
            }
            
            Button {
                viewModel.buyTheme(theme: theme)
            } label: {
                Text(theme.isBought ? "구매완료": "\(theme.price)쌀")
                    .onuiFont(.body(.medium), color: theme.isBought ? .Primary.primary :.Primary.onPrimaryContainer)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(theme.isBought ? .clear: Color.Primary.primaryContainer)
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.Primary.primary, lineWidth: 1)
                            .opacity(theme.isBought ? 1: 0)
                    }
            }
            .disabled(theme.isBought)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .onuiAlert(
            isPresented: $viewModel.isShowAlert,
            title: "테마 즉시 적용",
            content:
"""
홍조쓰 테마를 바로 적용하시겠습니까?
보유 테마는 [설정 > 내정보] 아래에서 확인 가능해요!
"""
        ) {
            viewModel.changeTheme(completion: { theme in
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
            })
        }
    }
}
