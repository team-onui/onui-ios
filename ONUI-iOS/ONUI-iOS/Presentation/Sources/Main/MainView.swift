import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @State private var isOpen = false
    @State private var topPadding: CGFloat = 300
    @State private var last7DayHeight: CGFloat = 0
    
    @StateObject var viewModel: MainViewModel

    private let calendarView = DI.container.resolve(CalendarView.self)!
    private let recordView = DI.container.resolve(RecordView.self)!
    private let timelineView = DI.container.resolve(TimelineView.self)!
    private let settingView = DI.container.resolve(SettingView.self)!
    private let sunStoreView = DI.container.resolve(SunStoreView.self)!
    private let missionView = DI.container.resolve(MissionView.self)!
    private let chartView = DI.container.resolve(ChartView.self)!

    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        let emptyView = appState.theme.toNormalImage()
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
                                
                                NavigationLink(destination: missionView) {
                                    functionButton(title: "하나씩", subTitle: "과제", image:ImageResource.check)
                                }
                            }
                            
                            NavigationLink(destination: sunStoreView) {
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
                        }
                        .padding(.horizontal, 16)
                        
                        HStack(alignment: .top, spacing: spacing) {
                            NavigationLink(destination: MoonStoreView.init()) {
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
                            }
                            
                            VStack(spacing: spacing) {
                                HStack(spacing: spacing) {
                                    NavigationLink(destination: chartView) {
                                        functionButton(image: ImageResource.chartDonut)
                                    }
                                    
                                    NavigationLink(destination: settingView,label: {
                                        functionButton(image: ImageResource.setting)
                                    })
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
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("지난 7일")
                                            .onuiFont(.title(.large), color: .GrayScale.Surface.onSurface)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding(.horizontal, 16)
                                    
                                    HStack(spacing: 0) {
                                        var index = 0
                                        Spacer()

                                        ForEach(viewModel.sevenDaysAgoDay(), id: \.day) { date in
                                            if !viewModel.moodOfWeekList.isEmpty &&
                                                viewModel.moodOfWeekList.count > index &&
                                                viewModel.moodOfWeekList[index].createdAt.isSameDay(date) {
                                                var moodImage: MoodImage.Image {
                                                    var mood: MoodImage.Image.Mood {
                                                        index += 1
                                                        switch viewModel.moodOfWeekList[index - 1].mood {
                                                        case .veryBad:
                                                            return .veryBad
                                                        case .bad:
                                                            return .bad
                                                        case .normal:
                                                            return .normal
                                                        case .good:
                                                            return .good
                                                        case .veryGood:
                                                            return .veryGood
                                                        }
                                                    }
                                                    
                                                    switch appState.theme {
                                                    case .standard:
                                                        return .standard(mood)
                                                    case .hong:
                                                        return .hong(mood)
                                                    case .ssac:
                                                        return .ssac(mood)
                                                    case .nya:
                                                        return .nya(mood)
                                                    }
                                                }

                                                MoodImage(moodImage, isOn: true)
                                                    .frame(40)

                                                Spacer()
                                            } else {
                                                emptyView
                                                    .frame(40)
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                }
                                .padding(.vertical, 12)
                                .background(Color.GrayScale.Surface.surface)
                                .cornerRadius(24)
                                .overlay {
                                    GeometryReader(content: { geometry in
                                        Color.clear.onAppear {
                                            last7DayHeight = geometry.size.height + 16
                                        }
                                    })
                                }

                                VStack(alignment: .leading, spacing: 10) {
                                    HStack(alignment: .top) {
                                        Text("과제")
                                            .onuiFont(.title(.large), color: .GrayScale.Surface.onSurface)

                                        Spacer()
                                        
                                        Image(.missionIcon)
                                            .resizable()
                                            .frame(48)
                                    }

                                    ForEach(viewModel.missionList, id: \.id) { mission in
                                        missionProgressCell(
                                            title: mission.name,
                                            content: mission.goal,
                                            isCompleted: mission.isFinished
                                        )
                                    }
                                }
                                .padding(16)
                                .background(Color.GrayScale.Surface.surface)
                                .cornerRadius(24)

                                Rice(viewModel.rice)
                            }
                            .padding(8)
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
                            .frame(width: 14, height: 14)
                            .foregroundColor(.Primary.onPrimaryContainer)
                            .padding(20)
                            .background(Color.Primary.primaryContainer)
                            .cornerRadius(16)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.GrayScale.Surface.surface)
            }
//            .padding(.horizontal, 16)
            .navigate(to: calendarView, when: $viewModel.isNavigatedToCalendar)
            .onAppear(perform: viewModel.onAppear)
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

    @ViewBuilder
    func missionProgressCell(title: String, content: String, isCompleted: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                Text(title)
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)

                Text(title)
                    .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)

                if isCompleted {
                    Text("완료!")
                        .onuiFont(.label, color: .Primary.primary)
                }
            }

            RoundedRectangle(cornerRadius: 8)
                .fill(isCompleted ? Color.Primary.onPrimaryContainer: .Primary.primaryContainer)
                .frame(maxWidth: .infinity, maxHeight: 8)
        }
    }
}
