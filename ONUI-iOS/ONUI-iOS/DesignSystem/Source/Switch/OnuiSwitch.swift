import SwiftUI

struct OnuiSwitch: View {
    @Binding var isOn: Bool

    var body: some View {
        ZStack(alignment: isOn ? .trailing: .leading) {
            isOn ? Color.Primary.primary: .GrayScale.Outline.outline

            Circle().fill(Color.Primary.onPrimary)
                .frame(isOn ? 24: 16)
                .padding(isOn ? 4: 8)
        }
        .frame(width: 52, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(100)
        .onTapGesture {
            withAnimation {
                isOn.toggle()
            }
        }
    }
}
