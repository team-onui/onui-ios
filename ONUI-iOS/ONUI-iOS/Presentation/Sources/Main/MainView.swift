import SwiftUI

struct MainView: View {
    @State private var isOpen = false
    @State private var topPadding: CGFloat = 300
    @State private var last7DayHeight: CGFloat = 0
    
    @StateObject var viewModel: MainViewModel

    private let calendarView = DI.container.resolve(CalendarView.self)!
    private let recordView = DI.container.resolve(RecordView.self)!
    private let timelineView = DI.container.resolve(TimelineView.self)!
    private let moodDummy: [MoodImage.Image] = [
        .veryBad,
        .bad,
        .normal,
        .good,
        .veryGood,
        .good,
        .veryBad
    ]
    
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.GrayScale.Background.backgroundVariant
                        .ignoresSafeArea()
                    
                    VStack(spacing: 8) {
                        PagingBanner(height: $topPadding)
                        
                        let spacing: CGFloat = 8
                        HStack(alignment: .top, spacing: spacing) {
                            VStack(spacing: spacing) {
                                Button {
                                    viewModel.isNavigatedToCalendar.toggle()
                                } label: {
                                    functionButton(title: "한눈에", subTitle: "달력", image: ImageResource.calendar)
                                }
                                
                                functionButton(title: "하나씩", subTitle: "과제", image:ImageResource.check)
                            }
                            
                            ZStack(alignment: .topLeading) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("떡 꾸미기")
                                        .onuiFont(.title(.medium), color: .GrayScale.Surface.surfaceVariant)
                                    
                                    Text("햇님 방앗간")
                                        .onuiFont(.headline(.medium), color: .GrayScale.Surface.onSurface)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .zIndex(1)
                                
                                Image(.sun)
                                    .resizable()
                                    .frame(width: 162, height: 162)
                                    .padding([.top, .leading], 6)
                                    .offset(x: 50, y: 54)
                                    .zIndex(0)
                            }
                            .padding(.top, 12)
                            .padding(.leading, 16)
                            .background(Color.GrayScale.Surface.surface)
                            .cornerRadius(32)
                        }
                        .padding(.horizontal, 16)
                        
                        HStack(alignment: .top, spacing: spacing) {
                            ZStack(alignment: .topLeading) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("앱 꾸미기")
                                        .onuiFont(.title(.medium), color: .GrayScale.Surface.surfaceVariant)
                                    
                                    Text("달님 만물상")
                                        .onuiFont(.headline(.medium), color: .GrayScale.Surface.onSurface)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 3)
                                .zIndex(1)
                                
                                Image(.moon)
                                    .resizable()
                                    .frame(width: 173, height: 135.36)
                                    .padding(.top, 33)
                                    .offset(x: 59, y: 23.36)
                                    .zIndex(0)
                            }
                            .padding(.top, 12)
                            .padding(.leading, 13)
                            .background(Color.GrayScale.Surface.surface)
                            .cornerRadius(32)
                            
                            VStack(spacing: spacing) {
                                HStack(spacing: spacing) {
                                    functionButton(image: ImageResource.chartDonut)
                                    
                                    functionButton(image: ImageResource.setting)
                                }
                                
                                NavigationLink {
                                    timelineView
                                } label: {
                                    functionButton(title: "나누기", subTitle: "게시판", image: ImageResource.message)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    
                    GeometryReader(content: { geometry in
                        BottomSheetView(
                            isOpen: $isOpen,
                            maxHeight: geometry.size.height - topPadding - 16,
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
                                
                                HStack(spacing: 0) {
                                    Spacer()

                                    ForEach(moodDummy, id: \.self) { mood in
                                        MoodImage(mood, isOn: true)
                                            .frame(width: 40, height: 40)

                                        Spacer()
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
                        .padding(.horizontal, 8)
                    })
                    .ignoresSafeArea(edges: .bottom)
                }
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        recordView
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.Primary.onPrimaryContainer)
                            .padding(20)
                            .background(Color.Primary.primaryContainer)
                            .cornerRadius(16)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.GrayScale.Surface.surface)
            }
            .navigate(to: calendarView, when: $viewModel.isNavigatedToCalendar)
        }
    }
    
    @ViewBuilder
    func functionButton(
        title: String? = nil,
        subTitle: String? = nil,
        image: ImageResource
    ) -> some View {
        let isNil = title == nil
        HStack {
            if let title, let subTitle {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .onuiFont(.title(.small), color: .GrayScale.Surface.surfaceVariant)
                    
                    Text(subTitle)
                        .onuiFont(.headline(.small), color: .GrayScale.Surface.onSurface)
                }
                
                Spacer()
                
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.GrayScale.Surface.surfaceVariant)
                    .frame(32)
            } else {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.GrayScale.Surface.surfaceVariant)
                    .frame(32)
            }
        }
        .padding(.vertical, isNil ? 27: 12)
        .padding(.horizontal, isNil ? 28.5 :16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(32)
    }
}

#Preview {
    MainView(viewModel: .init())
}
