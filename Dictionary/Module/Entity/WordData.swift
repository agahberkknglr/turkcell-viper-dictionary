//
//  WordData.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

struct WordData: Decodable{
    let word, phonetic: String?
    let phonetics: [Phonetics]?
    let meanings: [Meanings]?
}

struct Phonetics: Decodable {
    let text, audio: String?
}

struct Meanings: Decodable {
    let partOfSpeech: String?
    let definitions: [Definitions]?
}

struct Definitions: Decodable {
    let definition, example: String?
    
}
