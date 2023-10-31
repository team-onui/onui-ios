import SwiftUI

struct CarouselView: View {
    enum CardType: Int {
        case 첫번째 = 0
        case 두번째
        case 세번째
        case 네번째
    }
    @StateObject var uiState: UIStateModel
    let spacing: CGFloat = 16
    let widthOfHiddenCards: CGFloat = 30

    var body: some View {
        CarouselCanvas {
            Carousel(
                numberOfItems: 4,
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                HStack(alignment: .bottom, spacing: spacing) {
                    cardView(cardType: .첫번째)
                    cardView(cardType: .두번째)
                    cardView(cardType: .세번째)
                    cardView(cardType: .네번째)
                }
            }
            .environmentObject(uiState)
        }
    }

    @ViewBuilder
    func cardView(cardType: CardType) -> some View {
        VStack(spacing: 8) {
            VStack {
                Text("asdf")
            }
            .padding(.vertical, 12)
            .frame(maxHeight: .infinity)
        }
        .frame(
            width: 320,
            height: uiState.activeCard == cardType.rawValue ? 400: 300
        )
        .background {
            Color.gray
                .cornerRadius(32)
        }
        .transition(.slide)
        .animation(.spring(), value: uiState.screenDrag)
    }
}
