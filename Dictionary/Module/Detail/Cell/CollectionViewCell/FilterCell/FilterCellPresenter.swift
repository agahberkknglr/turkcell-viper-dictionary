//
//  FilterCellPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import Foundation

protocol FilterCellPresenterProtocol {
    func load()
}

final class FilterCellPresenter {
    weak var view: FilterCellProtocol?
    private let filter: String
    
    init(view: FilterCellProtocol? = nil, filter: String) {
        self.view = view
        self.filter = filter
    }
}

extension FilterCellPresenter: FilterCellPresenterProtocol {
    func load() {
        view?.setfilterLabel(filter)
    }
}
