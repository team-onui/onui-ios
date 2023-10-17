import SwiftUI

struct MainView: View {
    @State private var isOpen = false
    @State private var topPadding: CGFloat = 0
    @State private var last7DayHeight: CGFloat = 0

    private let colorBall: [Color] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .purple
    ]
    var body: some View {
        VStack {
            ZStack {
                Color.GrayScale.Background.backgroundVariant
                    .ignoresSafeArea()

                VStack {
                    Text("감정 관리 팁 (PAGER)")
                        .onuiFont(.title(.large), color: .GrayScale.Background.onBackground)
                        .padding(.horizontal, 25)
                        .padding(.top, 41)
                        .padding(.bottom, 53)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .cornerRadius(32)
                        .overlay {
                            GeometryReader(content: { geometry in
                                Color.clear.onAppear {
                                    topPadding = geometry.size.height
                                }
                            })
                        }

                    Text("감정 관리 팁 (PAGER)")
                        .onuiFont(.title(.large), color: .GrayScale.Background.onBackground)
                        .padding(.horizontal, 25)
                        .padding(.top, 41)
                        .padding(.bottom, 187)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(32)
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.top, 16)

                GeometryReader(content: { geometry in
                    BottomSheetView(
                        isOpen: $isOpen,
                        maxHeight: geometry.size.height - topPadding - 24,
                        minHeight: last7DayHeight
                    ) {
                        VStack(spacing: 8) {
                            HStack {
                                Text("지난 7일")
                                    .onuiFont(.title(.large), color: .GrayScale.Surface.onSurface)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal, 16)

                            HStack {
                                ForEach(colorBall, id: \.self) { color in
                                    Circle().fill(color)
                                        .frame(width: 48, height: 48)
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        }
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(24)
                        .padding(8)
                        .overlay {
                            GeometryReader(content: { geometry in
                                Color.clear.onAppear {
                                    last7DayHeight = geometry.size.height
                                }
                            })
                        }
                    }
                })
                .ignoresSafeArea(edges: .bottom)
            }

            HStack {
                Spacer()

                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.Primary.onPrimaryContainer)
                    .padding(20)
                    .background(Color.Primary.primaryContainer)
                    .cornerRadius(16)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
        }
    }
}

#Preview {
    MainView()
}
