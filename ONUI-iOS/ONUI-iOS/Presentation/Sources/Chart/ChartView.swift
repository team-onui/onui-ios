import SwiftUI
import Charts

struct ChartView: View {
    enum PickerType: String, CaseIterable {
        case aLotMood = "가장 많은 감정"
        case monthMood = "한달 감정 변화"
    }

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ChartViewModel
    @State private var selectedPicker: PickerType = .aLotMood
    
    init(viewModel: ChartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            Picker("", selection: $selectedPicker) {
                ForEach(PickerType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            switch selectedPicker {
            case .aLotMood:
                Chart {
                    ForEach(viewModel.moodAnalysis.allMood, id: \.self) { storage in
                        BarMark(
                            x: .value("Mood", storage.mood.toKorean()),
                            y: .value("Count", storage.count)
                        )
                        .foregroundStyle(storage.color)
                    }
                }
                .chartXScale(domain: Mood.allCases.map { $0.toKorean() })
                .padding(.vertical ,12)
                .padding(.horizontal ,16)
            case .monthMood:
                Chart {
                    ForEach(viewModel.monthlyAnalysis.list, id: \.self) { storage in
                        LineMark(
                            x: .value("Date", storage.createdAt),
                            y: .value("Mood", storage.mood.toKorean())
                        )
                    }
                }
//                .chartXScale(domain: viewModel.calendarCellCount().day.map { $0 } )
                .chartYScale(domain: Mood.allCases.map { $0.toKorean() })
                .padding(.vertical ,12)
                .padding(.horizontal ,16)
            }
            
            Spacer()
        }
        .onAppear(perform: viewModel.onAppear)
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "분석") {
            dismiss()
        }
    }
}
