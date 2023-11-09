import SwiftUI
import SwiftUIFlowLayout

struct RecordView: View {
    @State private var selectedImage: UIImage?
    @StateObject var viewModel: RecordViewModel
    @Environment(\.dismiss) var dismiss

    init(
        viewModel: RecordViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        let questionStepRawValue = viewModel.questionStep.rawValue
        let answerStepRawValue = viewModel.answerStep.rawValue

        ScrollViewReader { value in
            ScrollView {
                VStack(spacing: 16) {
                    if questionStepRawValue >= 0 {
                        questionChat("안녕하세요~ 오늘은 어떤 하루였나요?", step: .mood)
                        
                        if answerStepRawValue >= 0 {
                            selectMood()
                                .id(0)
                        }
                    }
                    
                    if questionStepRawValue > 0 {
                        questionChat("""
                                     그렇군요, 오늘 하루 수고 많으셨어요.
                                     (선택한 표정에 따른 메시지)
                                     어떤 감정을 느끼셨나요?
                                     """, step: .moodDetail)
                        
                        if answerStepRawValue > 0 {
                            selectMoodDetail()
                                .id(1)
                        }
                    }
                    
                    if questionStepRawValue > 1 {
                        questionChat("""
                                 (선택한 감정에 따른 메시지)
                                 무슨 일이 있었는지 알려주세요.
                                 """, step: .happening)
                        
                        if answerStepRawValue > 1 {
                            let thisStep: RecordStep = .happening
                            VStack(spacing: 8) {
                                inputWhatIsHappening()
                                
                                if viewModel.answerStep == thisStep {
                                    nextButton(
                                        isFill: !viewModel.whatisHappening.isEmpty,
                                        step: thisStep
                                    )
                                    .padding(.horizontal, 16)
                                }
                            }
                            .id(2)
                        }
                    }
                    
                    if questionStepRawValue > 2 {
                        questionChat("""
                                 (격려 메시지)
                                 기억에 남는 사진이 있나요?
                                 """, step: .memorableImage)
                        
                        let thisStep: RecordStep = .memorableImage
                        if answerStepRawValue > 2 {
                            VStack(spacing: 8) {
                                inputMemorableImage()
                                
                                if viewModel.answerStep == thisStep {
                                    nextButton(
                                        isFill: selectedImage != nil,
                                        step: thisStep
                                    )
                                    .padding(.horizontal, 16)
                                }
                            }
                            .id(3)
                        }
                    }
                    
                    if questionStepRawValue > 3 {
                        questionChat("다른 사람들과 감정을 공유해보실래요?", step: .share)
                        
                        if answerStepRawValue > 3 {
                            HStack(spacing: 8) {
                                nextButton(
                                    isFill: false,
                                    step: .share
                                ) {
                                    viewModel.writeDiary(.skip)
                                }
                                
                                Button {
                                    viewModel.writeDiary(.share)
                                    hideKeyboard()
                                } label: {
                                    Text("공유하기")
                                        .onuiFont(.body(.medium), color: .Primary.onPrimaryContainer)
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.Primary.primaryContainer)
                                        .cornerRadius(24)
                                }
                            }
                            .padding(.horizontal, 16)
                            .id(4)
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .onChange(of: selectedImage) { image in
                guard let image else { return }
                viewModel.fetchImageUrl(image: image)
            }
            .onChange(of: viewModel.questionStep) { newValue in
                viewModel.isLoadingChat = true
                delayAfter(viewModel.loadingTime) {
                    deferDelayAfter(){
                        withAnimation {
                            value.scrollTo(newValue.rawValue, anchor: .bottom)
                        }
                    }
                    withAnimation {
                        viewModel.isLoadingChat = false
                        viewModel.answerStep.nextStep()
                    }
                }
            }
        }
        .onAppear {
            viewModel.questionStep.nextStep()
        }
        .hideKeyboardWhenTap()
        .background(Color.GrayScale.Background.background)
        .imagePicker(
            isShow: $viewModel.isShowImagePicker,
            uiImage: $selectedImage
        )
        .setBackButton(title: "기록하기") {
            dismiss()
        }
    }

    @ViewBuilder
    func questionChat(_ chatString: String, step: RecordStep) -> some View {
        HStack(spacing: 8) {
            OnuiImage(.chatProfile)
                .frame(48)

            if step == viewModel.questionStep && viewModel.isLoadingChat {
                HStack(spacing: 8) {
                    Circle().fill(Color.GrayScale.Surface.onSurfaceVariant)
                        .frame(8)
                    Circle().fill(Color.GrayScale.Surface.onSurface)
                        .frame(8)
                    Circle().fill(Color.GrayScale.Surface.onSurfaceVariant)
                        .frame(8)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Surface.surface)
                .cornerRadius(16)
            } else {
                Text(chatString)
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Surface.surface)
                    .cornerRadius(16)
            }

            Spacer()
        }
        .padding(.horizontal, 8)
    }

    @ViewBuilder
    func nextButton(isFill: Bool, step: RecordStep, action: (() -> Void)? = nil) -> some View {
        var foregroundColor: Color {
            isFill ?
                .Primary.onPrimaryContainer:
                .GrayScale.Background.onBackgroundVariant
        }

        Button {
            (action ?? { })()
            
            hideKeyboard()
            withAnimation {
                if step == viewModel.questionStep && viewModel.answerStep == viewModel.questionStep {
                    viewModel.questionStep.nextStep()
                }
            }
        } label: {
            Text(isFill ? "작성 완료": "건너뛰기")
                .onuiFont(.body(.medium), color: foregroundColor)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    if isFill {
                        Color.Primary.primaryContainer
                    } else {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.GrayScale.Background.onBackgroundVariant, lineWidth: 1)
                    }
                }
                .cornerRadius(24)
        }
    }

    @ViewBuilder
    func selectMood() -> some View {
        VStack(spacing: 8) {
            Text("오늘은 어떤 하루였나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)

            HStack {
                ForEach(Mood.allCases, id: \.self) { mood in
                    Button {
                        viewModel.selectedMood = mood
                        if viewModel.answerStep == .mood && viewModel.answerStep == viewModel.answerStep {
                            withAnimation {
                                viewModel.questionStep.nextStep()
                            }
                        }
                    } label: {
                        MoodImage(
                            mood.moodImage(),
                            isOn: viewModel.selectedMood == mood
                        )
                        .frame(48)
                    }
                    
                    if mood != .veryBad {
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func selectMoodDetail() -> some View {
        VStack(spacing: 8) {
            Text("오늘 어떤 감정을 느끼셨나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
                .padding(.horizontal, 16)

            FlowLayout(
                mode: .scrollable,
                binding: $viewModel.selectedMoodDetail,
                items: viewModel.moodDetailList,
                itemSpacing: 4
            ) { moodDetail in
                var foregroundColor: Color {
                    viewModel.selectedMoodDetail.contains(moodDetail) ?
                        .Primary.primary :
                        .GrayScale.Outline.outline
                }

                Button {
                    if viewModel.selectedMoodDetail.contains(moodDetail) {
                        viewModel.selectedMoodDetail.removeAll { $0 == moodDetail }
                    } else {
                        viewModel.selectedMoodDetail.append(moodDetail)
                    }
                    if viewModel.questionStep == viewModel.answerStep {
                        if viewModel.answerStep == .moodDetail {
                            withAnimation {
                                viewModel.questionStep.nextStep()
                            }
                        }
                    }
                } label: {
                    Text(moodDetail)
                        .onuiFont(.label, color: foregroundColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(foregroundColor, lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
        }
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func inputWhatIsHappening() -> some View {
        VStack(spacing: 8) {
            Text("무슨 일이 있었나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
            
            TextField("", text: $viewModel.whatisHappening, axis: .vertical)
                .onuiFont(.body(.medium), color: .black)
                .accentColor(.black)
                .lineLimit(...4)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Outline.outlineVariant)
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func inputMemorableImage() -> some View {
        let screenWidthSize: CGFloat = UIScreen.main.bounds.size.width
        VStack(spacing: 8) {
            Text("사진을 선택해주세요")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: (screenWidthSize - 64) / 2,
                        maxHeight: screenWidthSize - 64
                    )
                    .cornerRadius(16)
            } else {
                Button {
                    DispatchQueue.main.async {
                        viewModel.isShowImagePicker.toggle()
                    }
                } label: {
                    Image(systemName: "photo")
                        .foregroundColor(.GrayScale.Surface.onSurfaceVariant)
                        .imageScale(.large)
                        .frame(
                            maxWidth: .infinity, 
                            minHeight: (screenWidthSize - 64) / 2
                        )
                        .background(Color.GrayScale.Outline.outlineVariant)
                        .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }
}
