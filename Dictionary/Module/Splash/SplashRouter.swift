//
//  SplashRouter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 7.06.2024.
//

import Foundation
import UIKit

enum SplashRoutes {
    case search
}

protocol SplashRouterProtocol {
    func navigate(_ route: SplashRoutes)
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
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .search:
            guard let window = viewController?.view.window else { return }
            let searchVC = SearchRouter.createModule()
            let navigationController = UINavigationController(rootViewController: searchVC)
            window.rootViewController = navigationController
        }
    }
}
