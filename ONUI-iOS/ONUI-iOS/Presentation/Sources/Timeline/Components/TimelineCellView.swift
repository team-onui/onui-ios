import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct TimelineCellView: View {
    let textLineLimit: Int?
    let screenWidthSize: CGFloat = UIScreen.main.bounds.size.width
    let timeline: TimelineEntity

    init(timeline: TimelineEntity, lineLimit: Bool = true) {
        self.timeline = timeline
        self.textLineLimit = lineLimit ? 5: nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(timeline.writer)
                .onuiFont(.body(.medium), color: .black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if let imageUrl = timeline.image {
                KFImage(URL(string: imageUrl))
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
                items: timeline.tagList,
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
            
            Text(timeline.content)
                .lineLimit(textLineLimit)
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurfaceVariant)
                .multilineTextAlignment(.leading)
            
            Text("댓글 \(timeline.commentCount)개")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
    }
}
