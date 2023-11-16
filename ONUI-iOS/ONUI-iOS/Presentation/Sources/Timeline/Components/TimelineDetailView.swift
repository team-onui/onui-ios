import SwiftUI
import Combine

struct TimelineDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TimelineDetailViewModel
    var timeline: TimelineEntity
    private let onComment: () -> Void

    init(
        timeline: TimelineEntity,
        viewModel: TimelineDetailViewModel,
        onComment: @escaping () -> Void
    ) {
        self.timeline = timeline
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onComment = onComment
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        Text("\(viewModel.title)")
                            .onuiFont(.title(.medium), color: .black)
                        
                        TimelineCellView(timeline: timeline, lineLimit: false)
                            .padding(.horizontal, 16)
                        
                        ForEach(viewModel.commentList, id: \.id) { chat in
                            questionChat(hex: chat.userTheme, text: chat.content)
                                .tag(chat.id)
                        }

                    }
                    .padding(.vertical, 12)
                }
                .onChange(of: viewModel.commentList) { value in
                    delayAfter(0.5){
                        deferDelayAfter {
                            withAnimation {
                                proxy.scrollTo(value.last?.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }

            HStack(spacing: 10) {
                TextField("", text: $viewModel.myComment, axis: .vertical)
                    .onuiFont(.body(.medium), color: .black)
                    .accentColor(.black)
                    .lineLimit(...4)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Outline.outlineVariant)
                    .cornerRadius(16)

                Button {
                    viewModel.postComment(id: timeline.id)
                    onComment()
                } label: {
                    Image(.paperPlain)
                        .resizable()
                        .frame(24)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.GrayScale.Surface.surface)
        }
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: timeline.writer) {
            dismiss()
        }
        .onAppear(perform: { viewModel.onAppear(id: timeline.id) })
    }
    
    @ViewBuilder
    func questionChat(hex: String, text: String) -> some View {
        HStack(spacing: 8) {
            Onui(.chat, colorHex: hex, frame: 48)
            
            Text(text)
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Surface.surface)
                .cornerRadius(16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
