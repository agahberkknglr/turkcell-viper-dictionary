//
//  SearchPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

protocol SearchPresenterProtocol {
    func viewDidLoad()
    func searchButtonTapped(with word: String)
}

final class SearchPresenter {
    unowned var view: SearchViewControllerProtocol!
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    init(view: SearchViewControllerProtocol!, router: SearchRouterProtocol, interactor: SearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        view.setupKeyboardObservers()
        view.setupTapGesture()
        view.setupSearchBar()
        view.isSearchBarEmpty()
    }
    
    func searchButtonTapped(with word: String) {
        router.navigateToDetail(with: word)
    }
    
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
}
