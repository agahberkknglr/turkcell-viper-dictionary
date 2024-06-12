//
//  ErrorResponse.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 12.06.2024.
//

import Foundation

struct ErrorResponse: Decodable {
    let title: String
    let message: String
    let resolution: String
}
