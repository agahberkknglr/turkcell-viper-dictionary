//
//  DetailInteractor.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import Foundation

fileprivate var wordService = WordService()

protocol DetailInteractorProtocol {
    func fetchWord(with word: String)
}

protocol DetailInteractorOutputProtocol {
    func fetchWordOutputs(_ wordData: WordData)
}

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    func fetchWord(with word: String) {
        wordService.downloadWord(word: word) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let wordData):
                self.output?.fetchWordOutputs(wordData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
