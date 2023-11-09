import SwiftUI

struct PagingBanner: View {
    @State private var pageIndex = 0
    @Binding var height: CGFloat
    private let images: [Image] = [
        Image(.page1),
        Image(.page2),
        Image(.page3),
        Image(.page4)
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $pageIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    let image = images[index]

                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .tag(index)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    height = proxy.size.height
                                }
                            }
                        )
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(maxHeight: height)

            pagingIndicator()
                .padding(.bottom, 12)
                .padding(.trailing, 16)
        }
        .cornerRadius(24)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    @ViewBuilder
    func pagingIndicator() -> some View {
        HStack(spacing: 8) {
            ForEach(0..<images.count, id: \.self) { index in
                let isSameIndex: Bool = index == pageIndex

                Capsule()
                    .fill(
                        isSameIndex ?
                        Color.GrayScale.Background.onBackground :
                                .GrayScale.Background.onBackgroundVariant
                    )
                    .frame(width: isSameIndex ? 24 : 8, height: 8)
                    .animation(
                        .spring(
                            response: 0.5,
                            dampingFraction: 0.7,
                            blendDuration: 1
                        ),
                        value: pageIndex
                    )
                    .onTapGesture {
                        self.pageIndex = index
                    }
            }
        }
    }
}

#Preview {
    PagingBanner(height: .constant(.infinity))
}
