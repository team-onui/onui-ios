import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct TimelineCellView: View {
    let textLineLimit: Int?
    let screenWidthSize: CGFloat = UIScreen.main.bounds.size.width
    let title: String = "이름"
    var imageUrl: URL? = nil
    let moodDetails: [String] = [
        "어쩔티비", "저쩔티비", "안궁티비"
    ]

    init(lineLimit: Bool = true) {
        self.textLineLimit = lineLimit ? 5: nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .onuiFont(.body(.medium), color: .black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if let imageUrl {
                KFImage(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: (screenWidthSize - 64) / 2,
                        maxHeight: screenWidthSize - 64
                    )
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }
            
            FlowLayout(
                mode: .scrollable,
                items: moodDetails,
                itemSpacing: 0
            ) { moodDetail in
                Text(moodDetail)
                    .onuiFont(.label, color: .Primary.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.Primary.primary, lineWidth: 1)
                    }
                    .padding(.horizontal, 4)
            }
            
            Text("고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아 고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아 고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아 고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아 고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아고양이가 좋아 고양이가 좋아 고양이가 좋아 고양이가 좋아")
                .lineLimit(textLineLimit)
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurfaceVariant)
                .multilineTextAlignment(.leading)
            
            Text("댓글 <n>개")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
    }
}
