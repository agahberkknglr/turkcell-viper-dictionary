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
    func meaningForSection(_ section: Int) -> WordData.Meanings
    func tapPlaySound()
    
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol
    let interactor: DetailInteractorProtocol
    let word: String
    private var wordData: WordData?
    private var audioURL: URL?
    
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
    
    func meaningForSection(_ section: Int) -> WordData.Meanings {
        return wordData!.meanings![section]
    }
    
    func tapPlaySound() {
        if let audioURL = audioURL {
            view?.playAudio(from: audioURL)
        }
    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchWordOutputs(_ wordData: WordData) {
        self.wordData = wordData
        
        view?.setWordTitleLabel(with: wordData.word ?? "")
        view?.setSynonymLabel(with: wordData.phonetic ?? "")
        
        if let phonetics = wordData.phonetics, let audioString = phonetics.first(where: { $0.audio != nil && !$0.audio!.isEmpty })?.audio, let url = URL(string: audioString) {
            self.audioURL = url
            self.view?.setupSoundButton(isEnabled: true)
        } else {
            self.audioURL = nil
            self.view?.setupSoundButton(isEnabled: false)
        }
        
        view?.reloadData()
        
    }
}
