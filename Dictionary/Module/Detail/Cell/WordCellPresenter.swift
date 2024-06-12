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
    private let example: String
    private let index: Int
    
    init(view: WordCellProtocol? = nil, partOfSpeech: String, definition: String, example: String, index: Int) {
        self.view = view
        self.partOfSpeech = partOfSpeech
        self.definition = definition
        self.example = example
        self.index = index
    }
}

extension WordCellPresenter: WordCellPresenterProtocol {
    func load() {
        let formattedPartOfSpeech = "\(index + 1) - \(partOfSpeech)"
        view?.setPartOfSpeechLabel(formattedPartOfSpeech)
        view?.setDefinitionLabel(definition)
        view?.setExampleLabel(example)
    }
}
