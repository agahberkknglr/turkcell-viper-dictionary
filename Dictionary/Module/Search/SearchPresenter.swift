//
//  SearchPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation
import CoreData

protocol SearchPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func searchButtonTapped(with word: String)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(_ row: Int) -> String
}

final class SearchPresenter {
    unowned var view: SearchViewControllerProtocol!
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    private var searchHistory: [String] = []
    private var lastFiveSearchHistory: [String] {
        return Array(searchHistory.suffix(5))
    }
    
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
        view.setTableView()
        fetchSearchHistory()
    }
    
    func viewWillAppear() {
        fetchSearchHistory()
        view.updateSearchHistory()
    }
    
    func searchButtonTapped(with word: String) {
        CoreDataManager.shared.saveWord(recent: word)
        fetchSearchHistory()
        router.navigateToDetail(with: word)
    }
    
    private func fetchSearchHistory() {
        searchHistory = CoreDataManager.shared.fetchSearchHistory()
        view.updateSearchHistory()
    }
    
    func numberOfRowsInSection() -> Int {
        lastFiveSearchHistory.count
    }
    
    func cellForRowAt(_ row: Int) -> String {
         lastFiveSearchHistory[row]
    }

}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
}
