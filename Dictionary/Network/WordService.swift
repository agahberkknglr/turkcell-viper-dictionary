//
//  WordService.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

class WordService {
    
    func downloadWord(word: String, completion: @escaping (Result<WordData, Error>) -> ()) {
        guard let url = URL(string: API.searchUrl(word: word)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                completion(self.handelingWord(data))
            case .failure(let error):
                self.handelingError(error)
            }
        }
    }
    
    func downloadWordSynonym(word: String, completion: @escaping (Result<[WordSynonymData], Error>) -> () ) {
        guard let url = URL(string: API.wordSynonymUrl(word: word)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let data):
                completion(self.handelingSynonym(data))
            case.failure(let error):
                self.handelingError(error)
            }
        }
    }
    
    private func handelingError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handelingWord(_ data: Data) -> Result<WordData, Error> {
        do {
            let word = try JSONDecoder().decode([WordData].self, from: data)
            return .success(word.first!)
        } catch {
            return .failure(error)
        }
    }
    
    private func handelingSynonym(_ data: Data) -> Result<[WordSynonymData], Error> {
        do {
            let wordSynonym = try JSONDecoder().decode([WordSynonymData].self, from: data)
            return .success(wordSynonym)
        } catch {
            return .failure(error)
        }
    }
}
