//
//  DetailRouter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import Foundation

protocol DetailRouterProtocol {
    
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    static func createDetailModule(with word: String) -> DetailViewController {
        let view = DetailViewController()
        let router = DetailRouter()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor, word: word)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
}
