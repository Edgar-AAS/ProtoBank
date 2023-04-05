import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCards()
    func fetchData()
}

//botar talvez em dois protocolos
public protocol PresenterToRouterHomeProtocol {
    func goToProfile()
    func goToCardsController()
}
