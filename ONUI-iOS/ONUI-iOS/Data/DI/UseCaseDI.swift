import Foundation
import Swinject

public final class UseCaseDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        // Auth
        container.register(FetchGoogleSigninUrlUseCase.self) { resolver in
            FetchGoogleSigninUrlUseCase(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        container.register(GoogleSigninUseCase.self) { resolver in
            GoogleSigninUseCase(
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

        // User
        container.register(RenameUseCase.self) { resolver in
            RenameUseCase(
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
    }
}
