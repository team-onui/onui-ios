import SwiftUI

struct TimelineView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: TimelineViewModel

    init(
        viewModel: TimelineViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("< \(viewModel.title) >")
                    .onuiFont(.title(.medium), color: .black)
                
                LazyVStack {
                    ForEach(viewModel.timelineList, id: \.id) { timeline in
                        NavigationLink {
                            TimelineDetailView(timeline: timeline)
                        } label: {
                            TimelineCellView(timeline: timeline)
                                .onAppear(perform: viewModel.fetchTimelines)
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(Color.GrayScale.Background.background)
        .onAppear(perform: viewModel.onAppear)
        .setBackButton(title: "타임라인") {
            dismiss()
        }
    }
}
