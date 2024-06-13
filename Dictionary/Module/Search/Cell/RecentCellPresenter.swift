//
//  RecentCellPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import Foundation

protocol RecentCellPresenterProtocol {
    func load()
}

final class RecentCellPresenter {
    weak var view: RecentCellProtocol?
    private let recent: String
    
    init(view: RecentCellProtocol? = nil, recent: String) {
        self.view = view
        self.recent = recent
    }
}

extension RecentCellPresenter: RecentCellPresenterProtocol {
    func load() {
        view?.setRecentLabel(recent)
    }
}
