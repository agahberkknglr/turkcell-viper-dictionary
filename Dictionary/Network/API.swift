//
//  API.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

struct API {
    static let wordURL: String = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    static let synonymURL: String = "https://api.datamuse.com/words?rel_syn="
    
    static func searchUrl(word: String) -> String {
        wordURL + "\(word)"
    }
    
    static func wordSynonymUrl(word: String) -> String {
        synonymURL + "\(word)"
    }
}
