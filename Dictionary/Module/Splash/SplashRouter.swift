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
    
}

extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRouters) {
        switch route {
        case .search:
            break
        }
    }
}
