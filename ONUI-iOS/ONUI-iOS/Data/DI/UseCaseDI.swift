import Foundation
import Swinject

public final class UseCaseDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        // Auth
        container.register(GoogleSigninUseCase.self) { resolver in
            GoogleSigninUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        container.register(AppleSigninUseCase.self) { resolver in
            AppleSigninUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        container.register(RefreshTokenUseCase.self) { resolver in
            RefreshTokenUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        container.register(LogoutUseCase.self) { resolver in
            LogoutUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        container.register(WithdrawUseCase.self) { resolver in
            WithdrawUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }

        // User
        container.register(ChangeFilteringUseCase.self) { resolver in
            ChangeFilteringUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(ChangeUserColorUseCase.self) { resolver in
            ChangeUserColorUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(RenameUseCase.self) { resolver in
            RenameUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(FetchProfileUseCase.self) { resolver in
            FetchProfileUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(ChangeThemeUseCase.self) { resolver in
            ChangeThemeUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(FetchMyRiceUseCase.self) { resolver in
            FetchMyRiceUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        container.register(FetchMyThemeUseCase.self) { resolver in
            FetchMyThemeUseCase(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }

        // Image
        container.register(UploadImageUseCase.self) { resolver in
            UploadImageUseCase(
                imageRepository: resolver.resolve(ImageRepository.self)!
            )
        }

        // Diary
        container.register(WriteDiaryUseCase.self) { resolver in
            WriteDiaryUseCase(
                diaryRepository: resolver.resolve(DiaryRepository.self)!
            )
        }
        container.register(FetchDiaryDetailUseCase.self) { resolver in
            FetchDiaryDetailUseCase(
                diaryRepository: resolver.resolve(DiaryRepository.self)!
            )
        }
        container.register(FetchMoodOfMonthUseCase.self) { resolver in
            FetchMoodOfMonthUseCase(
                diaryRepository: resolver.resolve(DiaryRepository.self)!
            )
        }
        container.register(PutDiaryUseCase.self) { resolver in
            PutDiaryUseCase(
                diaryRepository: resolver.resolve(DiaryRepository.self)!
            )
        }
        container.register(FetchMoodOfWeekUseCase.self) { resolver in
            FetchMoodOfWeekUseCase(
                diaryRepository: resolver.resolve(DiaryRepository.self)!
            )
        }

        // Timeline
        container.register(FetchTimelinesUseCase.self) { resolver in
            FetchTimelinesUseCase(
                timelineRepository: resolver.resolve(TimelineRepository.self)!
            )
        }
        container.register(PostTimelineUseCase.self) { resolver in
            PostTimelineUseCase(
                timelineRepository: resolver.resolve(TimelineRepository.self)!
            )
        }

        // Comment
        container.register(FetchCommentUseCase.self) { resolver in
            FetchCommentUseCase(
                commentRepository: resolver.resolve(CommentRepository.self)!
            )
        }
        container.register(PostCommentUseCase.self) { resolver in
            PostCommentUseCase(
                commentRepository: resolver.resolve(CommentRepository.self)!
            )
        }

        // Shop
        container.register(FetchThemeListUseCase.self) { resolver in
            FetchThemeListUseCase(
                shopRepository: resolver.resolve(ShopRepository.self)!
            )
        }
        container.register(BuyThemeUseCase.self) { resolver in
            BuyThemeUseCase(
                shopRepository: resolver.resolve(ShopRepository.self)!
            )
        }
    }
}
