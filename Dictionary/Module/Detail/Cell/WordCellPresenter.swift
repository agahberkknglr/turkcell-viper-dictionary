//
//  WordCellPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 11.06.2024.
//

import Foundation

protocol WordCellPresenterProtocol {
    func load()
}

final class WordCellPresenter {
    weak var view: WordCellProtocol?
    private let partOfSpeech: String
    private let definition: String
    
    init(view: WordCellProtocol? = nil, partOfSpeech: String, definition: String) {
        self.view = view
        self.partOfSpeech = partOfSpeech
        self.definition = definition
    }
}

extension WordCellPresenter: WordCellPresenterProtocol {
    func load() {
        view?.setPartOfSpeechLabel(partOfSpeech)
        view?.setDefinitionLabel(definition)
    }
}
