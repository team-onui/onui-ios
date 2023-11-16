import Foundation

enum Page {
    case signin
    case main
    case splash
}

final class AppState: ObservableObject {
    init(page: Page, theme: Theme) {
        self.page = page
        self.theme = theme
    }

    @Published public var page: Page
    @Published public var theme: Theme
}
