import Foundation
import Domain
import Presentation
import Infra
import Data

func makeCardsViewController(fetchCardList: FetchCardList) -> CardsViewController {
    let viewController = CardsViewController()
    let router = CardsRouter(viewController: viewController, cardCreationFactory: makeCardCreationController, cardInformationFactory: makeCardInformationFactory)
    let presenter = CardListPresenter(fetchCardList: fetchCardList, cardsView: WeakVarProxy(viewController), router: router)
    viewController.presenter = presenter
    return viewController
}
