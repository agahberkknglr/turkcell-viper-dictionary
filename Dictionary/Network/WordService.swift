//
//  WordService.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

class WordService {
    
    func downloadWord(word: String, completion: @escaping (WordData?) -> ()) {
        guard let url = URL(string: API.searchUrl(word: word)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                completion(self.handelingData(data))
            case .failure(let error):
                self.handelingError(error)
            }
        }
    }
    
    func downloadWordSynonym(word: String, completion: @escaping ([WordSynonymData]?) -> () ) {
        guard let url = URL(string: API.wordSynonymUrl(word: word)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let data):
                completion(self.handelingData(data))
            case.failure(let error):
                self.handelingError(error)
            }
        }
    }
    
    private func handelingError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handelingData(_ data: Data) -> WordData? {
        do {
            let word = try JSONDecoder().decode(WordData.self, from: data)
            return word
        } catch {
            print(error)
            return nil
        }
    }
    
    private func handelingData(_ data: Data) -> [WordSynonymData]? {
        do {
            let wordSynonym = try JSONDecoder().decode(WordSynonymArray.self, from: data)
            return wordSynonym
        } catch {
            print(error)
            return nil
        }
    }
}
