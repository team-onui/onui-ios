import Combine
import Foundation

final class CalendarViewModel: BaseViewModel {
    @Published var shortDiaryList: [ShortDiaryEntity] = []
    @Published var selectedDate: Date = .init()
    @Published var appearedDate: Date = .init()
    @Published var allDates: [CalendarSheetModel] = []
    @Published var sheetDetail: DiaryDetailEntity?
    var appearedDateString: String {
        "\(appearedDate.year)년 \(appearedDate.month)월"
    }
    private let fetchMoodOfMonthUseCase: FetchMoodOfMonthUseCase
    private let fetchDiaryDetailUseCase: FetchDiaryDetailUseCase

    init(fetchMoodOfMonthUseCase: FetchMoodOfMonthUseCase, fetchDiaryDetailUseCase: FetchDiaryDetailUseCase) {
        self.fetchMoodOfMonthUseCase = fetchMoodOfMonthUseCase
        self.fetchDiaryDetailUseCase = fetchDiaryDetailUseCase
    }
    func onAppear() {
        fetchMoodOfMonth()
        fetchDiaryDetail(date: selectedDate)
    }

    func moveToNextMonth() {
        appearedDate = appearedDate.adding(by: .month, value: 1)
        fetchMoodOfMonth()
    }

    func moveToPreviousMonth() {
        appearedDate = appearedDate.adding(by: .month, value: -1)
        fetchMoodOfMonth()
    }

    func fetchDiaryDetail(date: Date) {
        addCancellable(fetchDiaryDetailUseCase.execute(date: date)) { detail in
            self.sheetDetail = detail
        } onReceiveError: { _ in
            self.sheetDetail = nil
        }
    }

    private func fetchMoodOfMonth() {
        addCancellable(
            fetchMoodOfMonthUseCase.execute(year: appearedDate.year, month: appearedDate.month)
        ) { [weak self] shortDiaryList in
            self?.shortDiaryList = shortDiaryList

            let calendar = Calendar.current
            guard let monthDays = self?.appearedDate.fetchAllDatesInCurrentMonth() else { return }
            var index = 0
            var days = monthDays.map { monthDay in
                var diary: ShortDiaryEntity? {
                    if shortDiaryList.isEmpty {
                        return nil
                    } else {
                        return shortDiaryList[index]
                    }
                }
                if let diary {
                    let isToDay: Bool = diary.createdAt.day == monthDay.day

                    var id: String {
                        if isToDay {
                            return diary.id
                        } else {
                            return UUID().uuidString
                        }
                    }

                    var moodType: Mood? {
                        if isToDay {
                            let mood = diary.mood
                            switch mood {
                            case .worst:
                                return .veryBad
                            case .bad:
                                return .bad
                            case .notBad:
                                return .normal
                            case .fine:
                                return .good
                            case .good:
                                return .veryGood
                            }
                        } else { return nil }
                    }
//
                    if isToDay && index < shortDiaryList.count - 1 {
                        index += 1
                    }

                    return CalendarSheetModel(id: id, date: monthDay, day: monthDay.day, mood: moodType)
                } else {
                    return CalendarSheetModel(id: UUID().uuidString, date: monthDay, day: monthDay.day, mood: nil)
                }
            }
            
            let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? .init())
            for _ in 0..<(firstWeekday + 5) % 7 {
                days.insert(CalendarSheetModel(id: UUID().uuidString, date: Date(), day: -1, mood: nil), at: 0)
            }
            self?.allDates = days
        }
    }
}
