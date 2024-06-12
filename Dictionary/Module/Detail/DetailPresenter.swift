//
//  DetailPresenter.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    //func cellForRowAt(indexPath: IndexPath) -> WordCellPresenterProtocol
    func meaningForSection(_ section: Int) -> WordData.Meanings
    
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol
    let interactor: DetailInteractorProtocol
    let word: String
    private var wordData: WordData?
    //private var cellPresenters: [WordCellPresenter] = []
    
    init(view: DetailViewControllerProtocol? = nil, router: DetailRouterProtocol, interactor: DetailInteractorProtocol, word: String) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.word = word
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.setTableView()
        interactor.fetchWord(with: word)
    }
    
    func numberOfSections() -> Int {
        wordData?.meanings?.count ?? 0
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        wordData?.meanings?[section].definitions?.count ?? 0
    }
    
    //func cellForRowAt(indexPath: IndexPath) -> WordCellPresenterProtocol {
    //    return cellPresenters[indexPath.row]
    //}
    
    func meaningForSection(_ section: Int) -> WordData.Meanings {
        return wordData!.meanings![section]
    }
    
    //func meaningForRowAt(indexPath: IndexPath) -> WordData.Meanings? {
    //    //return wordData!.meanings![indexPath.row]
    //    guard let meanings = wordData?.meanings, indexPath.row < meanings.count else {
    //        return nil
    //    }
    //    return meanings[indexPath.row]
    //}
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchWordOutputs(_ wordData: WordData) {
        self.wordData = wordData

        //if let meanings = wordData.meanings {
        //    var tempCellPresenters: [WordCellPresenter] = []
        //    for meaning in meanings {
        //        guard let partOfSpeech = meaning.partOfSpeech, let definitions = meaning.definitions else {
        //            continue
        //        }
        //        for definition in definitions {
        //            if let def = definition.definition {
        //                let presenter = WordCellPresenter(partOfSpeech: partOfSpeech, definition: def)
        //                tempCellPresenters.append(presenter)
        //                print(meaning.partOfSpeech ?? "")
        //                print(def)
        //            }
        //        }
        //    }
        //    cellPresenters = tempCellPresenters
        //}

        
        view?.setWordTitleLabel(with: wordData.word ?? "")
        view?.setSynonymLabel(with: wordData.phonetic ?? "")
        view?.reloadData()
        
    }
}
