import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State private var sheetHeight: CGFloat = 300

    @StateObject var viewModel: CalendarViewModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let currentDate = Date()

    init(viewModel: CalendarViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                OnuiImage(.chevronLeft)
                    .frame(24)
                    .onTapGesture(perform: viewModel.moveToPreviousMonth)

                Text(viewModel.appearedDateString)
                    .onuiFont(.title(.medium), color: .black)

                OnuiImage(.chevronRight)
                    .frame(24)
                    .onTapGesture(perform: viewModel.moveToNextMonth)
            }

            LazyVGrid(columns: columns) {
                ForEach(DayOfWeekType.allCases, id: \.self) { week in
                    Text(week.toKorean())
                        .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
                }

                ForEach(viewModel.allDates, id: \.id) { model in
                    VStack(spacing: 0) {
                        if model.day != -1 {
                            Group {
                                if let mood = model.mood {
                                    var moodImage: MoodImage.Image {
                                        switch appState.theme {
                                        case .standard:
                                            return .standard(mood.moodImage())
                                        case .hong:
                                            return .hong(mood.moodImage())
                                        case .ssac:
                                            return .ssac(mood.moodImage())
                                        case .nya:
                                            return .nya(mood.moodImage())
                                        }
                                    }
                                    MoodImage(moodImage, isOn: true)
                                } else {
                                    appState.theme.toNormalImage()
                                }
                            }
                            .frame(36)
                            .overlay {
                                VStack {
                                    if viewModel.selectedDate.isSameDay(model.date) {
                                        MoodImage(.stroke(appState.theme), isOn: true)
                                            .frame(36)
                                    }
                                }
                            }

                            Text("\(model.day)")
                                .onuiFont(
                                    .label,
                                    color: currentDate.isSameDay(model.date) ?
                                        .Primary.primary:
                                            .black
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        viewModel.selectedDate = model.date
                        viewModel.fetchDiaryDetail(date: model.date)
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)

            Spacer().overlay {
                GeometryReader { proxy in
                    Color.clear.onChange(of: proxy.size.height) { height in
                        sheetHeight = height
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "캘린더") {
            dismiss()
        }
        .onAppear(perform: viewModel.onAppear)
        .sheet(isPresented: .constant(true)) {
            DiaryView(currentDate: viewModel.selectedDate, diaryDetail: viewModel.sheetDetail)
                .presentationDetents([.height(sheetHeight), .large])
                .presentationCornerRadius(32)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
        }
    }
}
