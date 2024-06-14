//
//  SearchRouter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

protocol SearchRouterProtocol {
    func navigateToDetail(with word: String)
}

final class SearchRouter {
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension SearchRouter: SearchRouterProtocol {
    func navigateToDetail(with word: String) {
        let detailVC = DetailRouter.createDetailModule(with: word)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
