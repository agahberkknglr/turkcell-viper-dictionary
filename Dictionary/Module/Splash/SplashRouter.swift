//
//  SplashRouter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 7.06.2024.
//

import Foundation

enum SplashRouters {
    case search
}

protocol SplashRouterProtocol {
    func navigate(_ route: SplashRouters)
}

final class SplashRouter {
    
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRouters) {
        switch route {
        case .search:
            break
        }
    }
}
