import SwiftUI

struct TimelineView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: TimelineViewModel
    
    private let postCommentUseCase: PostCommentUseCase
    private let fetchCommentUseCase: FetchCommentUseCase
    
    init(
        viewModel: TimelineViewModel,
        postCommentUseCase: PostCommentUseCase,
        fetchCommentUseCase: FetchCommentUseCase
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.postCommentUseCase = postCommentUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("< \(viewModel.title) >")
                    .onuiFont(.title(.medium), color: .black)
                
                LazyVStack {
                    ForEach(0..<viewModel.timelineList.count, id: \.self) { index in
                        NavigationLink {
                            TimelineDetailView(
                                timeline: viewModel.timelineList[index],
                                viewModel: .init(
                                    postCommentUseCase: postCommentUseCase,
                                    fetchCommentUseCase: fetchCommentUseCase
                                )
                            ) {
                                viewModel.timelineList[index].commentCount += 1
                            }
                        } label: {
                            TimelineCellView(timeline: viewModel.timelineList[index])
                                .onAppear(perform: viewModel.fetchTimelines)
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .refreshable {
            viewModel.onAppear()
        }
        .background(Color.GrayScale.Background.background)
        .onAppear(perform: viewModel.onAppear)
        .setBackButton(title: "타임라인") {
            dismiss()
        }
    }
}
