//
//  SynonymCellPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import Foundation

protocol SynonymCellPresenterProtocol {
    func load()
}

final class SynonymCellPresenter {
    weak var view: SynonymCellProtocol?
    private let synonym: String
    
    init(view: SynonymCellProtocol? = nil, synonym: String) {
        self.view = view
        self.synonym = synonym
    }
}

extension SynonymCellPresenter: SynonymCellPresenterProtocol {
    func load() {
        view?.setSynonym(synonym)
    }
}
