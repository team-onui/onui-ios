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
                Group {
                    switch cardType {
                    case .첫번째:
                        Image(.랜딩페이저상점)
                            .resizable()
                    case .두번째:
                        Image(.랜딩페이저전체)
                            .resizable()
                    case .세번째:
                        Image(.랜딩페이저달력)
                            .resizable()
                    case .네번째:
                        Image(.랜딩페이저기록)
                            .resizable()
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .frame(
            width: UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2),
            height: uiState.activeCard == cardType.rawValue ?
            UIScreen.main.bounds.height * 0.4546 :
                UIScreen.main.bounds.height * 0.4103
        )
        .transition(.slide)
        .animation(.spring(), value: uiState.screenDrag)
    }
}
