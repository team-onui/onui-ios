import SwiftUI

struct TimelineDetailView: View {
    @State private var text: String = ""
    @Environment(\.dismiss) var dismiss
    private let currentDate = Date()
    var title: String {
        "\(currentDate.month)월 \(currentDate.day)일"
    }
    
    private let chatDummy: [String] = [
        "ㅇㅈ 고양이 귀여움 ;;",
        "근데 강아지가 더 귀엽다는데",
        "ㄴ 너 흰둥이지?",
        "ㄴ ㄴㄴ 아닌데?",
        "ㄴ ㅋㅋㅋ 발뺌하지 마셈"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 12) {
                    Text("\(title)")
                        .onuiFont(.title(.medium), color: .black)
                    
                    TimelineCellView(lineLimit: false)
                        .padding(.horizontal, 16)
                    
                    ForEach(chatDummy, id: \.self) { chat in
                        questionChat(chat)
                    }

                }
                .padding(.vertical, 12)
            }

            HStack(spacing: 10) {
                TextField("", text: $text, axis: .vertical)
                    .onuiFont(.body(.medium), color: .black)
                    .accentColor(.black)
                    .lineLimit(...4)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Outline.outlineVariant)
                    .cornerRadius(16)

                Image(.paperPlain)
                    .resizable()
                    .frame(24)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
        }
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "<UserName>") {
            dismiss()
        }
    }
    
    @ViewBuilder
    func questionChat(_ chatString: String) -> some View {
        HStack(spacing: 8) {
            OnuiImage(.chatProfile)
                .frame(48)
            
            Text(chatString)
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Surface.surface)
                .cornerRadius(16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
