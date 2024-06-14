//
//  MockSearchRouter.swift
//  DictionaryTests
//
//  Created by Agah Berkin Güler on 14.06.2024.
//

import Foundation
@testable import Dictionary

final class MockSearchRouter: SearchRouterProtocol {
    
    var isNavigateToDetailCalled = false
    
    func navigateToDetail(with word: String) {
        isNavigateToDetailCalled = true
    }
    
    
}
