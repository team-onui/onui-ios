import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date?
    @State private var appearedDate: Date = .init()
    private var appearedDateString: String {
        "\(appearedDate.year)년 \(appearedDate.month)월"
    }
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let currentDate = Date()

    var body: some View {
        VStack(spacing: 35) {
            HStack(spacing: 8) {
                OnuiImage(.chevronLeft)
                    .frame(24)
                    .onTapGesture {
                        appearedDate = appearedDate.adding(by: .month, value: -1)
                    }

                Text(appearedDateString)
                    .onuiFont(.title(.medium), color: .black)

                OnuiImage(.chevronRight)
                    .frame(24)
                    .onTapGesture {
                        appearedDate = appearedDate.adding(by: .month, value: 1)
                    }
            }

            LazyVGrid(columns: columns) {
                ForEach(fetchWeekInKorean(), id: \.self) { week in
                    Text(week)
                        .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
                }

                ForEach(fetchAllDates(), id: \.id) { model in
                    VStack(spacing: 0) {
                        if model.day != -1 {
                            MoodImage(
                                model.mood?.moodImage() ?? .normal,
                                isOn: true,
                                renderingMode: model.mood == nil ? .template: .original
                            )
                            .foregroundColor(.GrayScale.gray3)
                            .frame(36)
                            .overlay {
                                VStack {
                                    if let selectedDate {
                                        if selectedDate.isSameDay(model.date) {
                                            OnuiImage(.moodBorder)
                                                .frame(36)
                                        }
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
                    .background {
                        Color.white
                    }
                    .onTapGesture {
                        selectedDate = model.date
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(24)

            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Background.background)
    }

    func fetchWeekInKorean() -> [String] {
        [
            "월",
            "화",
            "수",
            "목",
            "금",
            "토",
            "일"
        ]
    }

    func fetchAllDates() -> [CalendarSheetModel] {
        let calendar = Calendar.current
        var days = appearedDate.fetchAllDatesInCurrentMonth()
            .map { CalendarSheetModel(date: $0, day: $0.day) }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? .init())
        for _ in 0..<firstWeekday - 1 {
            days.insert(CalendarSheetModel(date: Date(), day: -1), at: 0)
        }
        return days
    }
}

#Preview {
    CalendarView()
}
