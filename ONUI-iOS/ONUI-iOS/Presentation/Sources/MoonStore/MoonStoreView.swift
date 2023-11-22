import SwiftUI

struct MoonStoreView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("추후 추가될 예정입니다 🧑‍💻")
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "달님 만물상") {
            dismiss()
        }
    }
}
