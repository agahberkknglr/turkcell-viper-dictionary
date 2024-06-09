//
//  SplashPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 7.06.2024.
//

import Foundation

protocol SplashPresenterProtocol {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol!, router: SplashRouterProtocol!, interactor: SplashInteractorProtocol!) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.router.navigate(.search)
        }
    }

}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
}
