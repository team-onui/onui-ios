import Foundation

enum Page {
    case signin
    case main
    case splash
}

final class AppState: ObservableObject {
    init(page: Page) {
        self.page = page
    }

    @Published public var page: Page
}
