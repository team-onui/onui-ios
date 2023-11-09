import SwiftUI

struct TimelineView: View {
    @Environment(\.dismiss) var dismiss
    private let currentDate = Date()
    var title: String {
        "\(currentDate.month)월 \(currentDate.day)일"
    }
    
    @StateObject var viewModel: TimelineViewModel

    init(
        viewModel: TimelineViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("< \(title) >")
                    .onuiFont(.title(.medium), color: .black)
                
                ForEach(0..<5) { i in
                    NavigationLink {
                        TimelineDetailView()
                    } label: {
                        TimelineCellView()
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "타임라인") {
            dismiss()
        }
    }
}
