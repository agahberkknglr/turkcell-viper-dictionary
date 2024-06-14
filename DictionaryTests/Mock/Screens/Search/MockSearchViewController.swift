//
//  MockHomeViewController.swift
//  DictionaryTests
//
//  Created by Agah Berkin Güler on 14.06.2024.
//

import Foundation
@testable import Dictionary

final class MockSearchViewController: SearchViewControllerProtocol {
    
    var isSetupKeyboardObserversCalled = false
    func setupKeyboardObservers() {
        isSetupKeyboardObserversCalled = true
    }
    
    var isSetupTapGestureCalled = false
    func setupTapGesture() {
        isSetupTapGestureCalled = true
    }
    
    var isSetupSearchBarCalled = false
    func setupSearchBar() {
        isSetupSearchBarCalled = true
    }
    
    var isSearchBarEmptyCalled = false
    func isSearchBarEmpty() {
        isSearchBarEmptyCalled = true
    }
    
    var isSetTableViewCalled = false
    func setTableView() {
        isSetTableViewCalled = true
    }
    
    var isUpdateSearchHistoryCalled = false
    func updateSearchHistory() {
        isUpdateSearchHistoryCalled = true
    }
    
    var isSetAccesibilityIdentifiersCalled = false
    func setAccessibilityIdentifiers() {
        isSetTableViewCalled = true
    }
    
    
}
