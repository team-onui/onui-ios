import Foundation

final class ChartViewModel: BaseViewModel {
    @Published var moodAnalysis: MoodAnalysisEntity = MoodAnalysisEntity(veryBad: 0, bad: 0, normal: 0, good: 0, veryGood: 0)
    @Published var monthlyAnalysis: MonthlyAnalysisEntity = MonthlyAnalysisEntity(list: [], message: "")

    private let fetchMoodAnalysisUseCase: FetchMoodAnalysisUseCase
    private let fetchMonthlyAnalysisUseCase: FetchMonthlyAnalysisUseCase

    init(
        fetchMoodAnalysisUseCase: FetchMoodAnalysisUseCase,
        fetchMonthlyAnalysisUseCase: FetchMonthlyAnalysisUseCase
    ) {
        self.fetchMoodAnalysisUseCase = fetchMoodAnalysisUseCase
        self.fetchMonthlyAnalysisUseCase = fetchMonthlyAnalysisUseCase
    }

    func onAppear() {
        fetchMoodAnalysis()
        fetchMonthlyAnalysis()
    }

    private func fetchMoodAnalysis() {
        addCancellable(fetchMoodAnalysisUseCase.execute()) { moodAnalysis in
            print(moodAnalysis)
            self.moodAnalysis = moodAnalysis
        }
    }

    private func fetchMonthlyAnalysis() {
        addCancellable(fetchMonthlyAnalysisUseCase.execute()) { monthlyAnalysis in
            self.monthlyAnalysis = monthlyAnalysis
        }
    }
    func calendarCellCount() -> (month: Int, day: [Int]) {
        let year = Date.init().year
        let month = Date.init().month
        let date = Date(timeIntervalSinceNow: 0)
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_kr")
        
        // 여기에 기입하지 않은 날짜는 1로 초기화가 된다
        _ = calendar.dateComponents([.year, .month], from: date)
        let myDateComponents = DateComponents(year: year, month: month)
        
        // day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: myDateComponents)
        let comp1 = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: startOfMonth!)
        
        // 이번 달의 마지막 날짜를 구해주기 위해서 다음달을 구한다 이것도 day를 넣어주지 않았기 때문에 1이 다음달의 1일이 나오게 된다
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth!)
        
        // 위에 값에서 day값을 넣어주지 않았기 떄문에 1이 나오게 되므로 마지막 날을 알기 위해서 -1을 해준다
        let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
        
        let comp2 = calendar.dateComponents([.day, .weekday, .weekOfMonth], from: endOfMonth!)

        let days: [Int] = (comp1.day!...comp2.day!).map { $0 }

        return (month, days)
    }

}
