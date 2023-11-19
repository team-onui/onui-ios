import SwiftUI

struct Rice: View {
    let rice: Int

    init(_ rice: Int) {
        self.rice = rice
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("쌀")
                    .onuiFont(.title(.large), color: .GrayScale.Surface.onSurface)

                Spacer()
                
                Image(.rice)
                    .resizable()
                    .frame(48)
            }

            Text("\(rice)쌀")
                .onuiFont(.headline(.large), color: .GrayScale.Surface.onSurface)
        }
        .padding(16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
    }
}
