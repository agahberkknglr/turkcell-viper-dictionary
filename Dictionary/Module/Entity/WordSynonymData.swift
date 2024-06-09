//
//  WordSynonymData.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import Foundation

struct WordSynonymData: Decodable {
    let word: String?
    let score: Int?
}

typealias WordSynonymArray = [WordSynonymData]
