import SwiftUI
import Kingfisher
import SwiftUIFlowLayout

struct DiaryView: View {
    let screenWidthSize: CGFloat = UIScreen.main.bounds.size.width
    private var title: String
    private let diaryDetail: DiaryDetailEntity?
    
    init(currentDate: Date, diaryDetail: DiaryDetailEntity?) {
        self.title = "\(currentDate.month)월 \(currentDate.day)일"
        self.diaryDetail = diaryDetail
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .onuiFont(.title(.medium), color: .black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 28)
                    .padding(.bottom, 8)
                
                if let diaryDetail {
                    if let imageUrl = diaryDetail.image {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: (screenWidthSize - 64) / 2,
                                maxHeight: screenWidthSize - 64
                            )
                            .cornerRadius(16)
                            .padding(.horizontal, 32)
                    }
                    
                    FlowLayout(
                        mode: .scrollable,
                        items: diaryDetail.tagList,
                        itemSpacing: 4
                    ) { moodDetail in
                        Text(moodDetail)
                            .onuiFont(.label, color: .Primary.primary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.Primary.primary, lineWidth: 1)
                            }
                    }
                    .padding(.horizontal, 12)
                    
                    Text(diaryDetail.content)
                        .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurfaceVariant)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}
