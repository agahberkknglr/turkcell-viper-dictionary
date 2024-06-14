//
//  SearchPresenterTests.swift
//  DictionaryTests
//
//  Created by Agah Berkin Güler on 14.06.2024.
//

import XCTest
@testable import Dictionary

final class SearchPresenterTests: XCTestCase {
    
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func testViewDidLoadInvokesRequiredViewMethods() {
        XCTAssertFalse(view.isSetupSearchBarCalled)
        XCTAssertFalse(view.isSearchBarEmptyCalled)
        XCTAssertFalse(view.isSetTableViewCalled)
        XCTAssertFalse(view.isSetupKeyboardObserversCalled)
        XCTAssertFalse(view.isSetupTapGestureCalled)
        presenter.viewDidLoad()
        XCTAssertTrue(view.isSetupSearchBarCalled)
        XCTAssertTrue(view.isSearchBarEmptyCalled)
        XCTAssertTrue(view.isSetTableViewCalled)
        XCTAssertTrue(view.isSetupKeyboardObserversCalled)
        XCTAssertTrue(view.isSetupTapGestureCalled)
    }
    
    func testViewWillAppearInvokesRequiredViewMethods() {
        XCTAssertFalse(view.isUpdateSearchHistoryCalled)
        presenter.viewWillAppear()
        XCTAssertTrue(view.isUpdateSearchHistoryCalled)
    }
}
