import Foundation
import Swinject

public final class PresentationDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(SigninViewModel.self) { resolver in
            SigninViewModel(
                googleSigninUseCase: resolver.resolve(GoogleSigninUseCase.self)!,
                appleSigninUseCase: resolver.resolve(AppleSigninUseCase.self)!
            )
        }
        container.register(SigninView.self) { resolver in
            SigninView(viewModel: resolver.resolve(SigninViewModel.self)!)
        }

        container.register(MainViewModel.self) { resolver in
            MainViewModel()
        }
        container.register(MainView.self) { resolver in
            MainView(viewModel: resolver.resolve(MainViewModel.self)!)
        }

        container.register(CalendarViewModel.self) { resolver in
            CalendarViewModel(
                fetchMoodOfMonthUseCase: resolver.resolve(FetchMoodOfMonthUseCase.self)!,
                fetchDiaryDetailUseCase: resolver.resolve(FetchDiaryDetailUseCase.self)!
            )
        }
        container.register(CalendarView.self) { resolver in
            CalendarView(viewModel: resolver.resolve(CalendarViewModel.self)!)
        }

        container.register(RecordViewModel.self) { resolver in
            RecordViewModel(
                writeDiaryUseCase: resolver.resolve(WriteDiaryUseCase.self)!,
                uploadImageUseCase: resolver.resolve(UploadImageUseCase.self)!, 
                postTimelineUseCase: resolver.resolve(PostTimelineUseCase.self)!
            )
        }
        container.register(RecordView.self) { resolver in
            RecordView(viewModel: resolver.resolve(RecordViewModel.self)!)
        }

        container.register(TimelineViewModel.self) { resolver in
            TimelineViewModel()
        }
        container.register(TimelineView.self) { resolver in
            TimelineView(viewModel: resolver.resolve(TimelineViewModel.self)!)
        }
    }
}
