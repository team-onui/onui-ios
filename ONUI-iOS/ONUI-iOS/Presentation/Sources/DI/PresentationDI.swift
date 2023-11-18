import Foundation
import Swinject

public final class PresentationDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(RootViewModel.self) { resolver in
            RootViewModel(
                refreshTokenUseCase: resolver.resolve(RefreshTokenUseCase.self)!,
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!
            )
        }
        container.register(RootView.self) { resolver in
            RootView(viewModel: resolver.resolve(RootViewModel.self)!)
        }

        container.register(SigninViewModel.self) { resolver in
            SigninViewModel(
                googleSigninUseCase: resolver.resolve(GoogleSigninUseCase.self)!,
                appleSigninUseCase: resolver.resolve(AppleSigninUseCase.self)!,
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!
            )
        }
        container.register(SigninView.self) { resolver in
            SigninView(viewModel: resolver.resolve(SigninViewModel.self)!)
        }

        container.register(MainViewModel.self) { resolver in
            MainViewModel(fetchMoodOfWeekUseCase: resolver.resolve(FetchMoodOfWeekUseCase.self)!)
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
            TimelineViewModel(
                fetchTimelinesUseCase: resolver.resolve(FetchTimelinesUseCase.self)!,
                fetchCommentUseCase: resolver.resolve(FetchCommentUseCase.self)!,
                postCommentUseCase: resolver.resolve(PostCommentUseCase.self)!
            )
        }
        container.register(TimelineView.self) { resolver in
            TimelineView(
                viewModel: resolver.resolve(TimelineViewModel.self)!,
                postCommentUseCase: resolver.resolve(PostCommentUseCase.self)!,
                fetchCommentUseCase: resolver.resolve(FetchCommentUseCase.self)!
            )
        }

        container.register(SettingViewModel.self) { resolver in
            SettingViewModel(
                changeFilteringUseCase: resolver.resolve(ChangeFilteringUseCase.self)!,
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!,
                withdrawUseCase: resolver.resolve(WithdrawUseCase.self)!,
                logoutUseCase: resolver.resolve(LogoutUseCase.self)!,
                changeUseColorUseCase: resolver.resolve(ChangeUserColorUseCase.self)!,
                renameUseCase: resolver.resolve(RenameUseCase.self)!
            )
        }
        container.register(SettingView.self) { resolver in
            SettingView(
                viewModel: resolver.resolve(SettingViewModel.self)!
            )
        }

        container.register(SunStoreViewModel.self) { resolver in
            SunStoreViewModel(
                changeThemeUseCase: resolver.resolve(ChangeThemeUseCase.self)!,
                buyThemeUseCase: resolver.resolve(BuyThemeUseCase.self)!,
                fetchMyRiceUseCase: resolver.resolve(FetchMyRiceUseCase.self)!,
                fetchThemeListUseCase: resolver.resolve(FetchThemeListUseCase.self)!
            )
        }
        container.register(SunStoreView.self) { resolver in
            SunStoreView(
                viewModel: resolver.resolve(SunStoreViewModel.self)!
            )
        }
        container.register(ChangeThemeViewModel.self) { resolver in
            ChangeThemeViewModel(
                changeThemeUseCase: resolver.resolve(ChangeThemeUseCase.self)!,
                fetchMyThemeUseCase: resolver.resolve(FetchMyThemeUseCase.self)!,
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!
                
            )
        }
        container.register(ChangeThemeView.self) { resolver in
            ChangeThemeView(
                viewModel: resolver.resolve(ChangeThemeViewModel.self)!
            )
        }
    }
}
