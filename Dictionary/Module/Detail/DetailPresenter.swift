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
    func numberOfItemInSection() -> Int
    func synonymForSection(_ section: Int) -> String
    func didSelectSynonym(_ synonym: String)
    func filterItems() -> Int
    func cellForFilter(_ index: IndexPath) -> String
    func filterByPartOfSpeech(_ partOfSpeech: String?, _  indexPath: IndexPath)
    func getSelectedFilterIndexes() -> [IndexPath]
    func meaningsForSelectedPartOfSpeech() -> [WordData.Meanings]
    func setTimer()
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol
    let interactor: DetailInteractorProtocol
    let word: String
    private var wordData: WordData?
    private var audioURL: URL?
    private var wordSynonymData: [String]?
    private var selectedPartOfSpeech: [String] = []
    private var selectedFilterIndexes: [IndexPath] = []
    private var timer: Timer?
    
    init(view: DetailViewControllerProtocol? = nil, router: DetailRouterProtocol, interactor: DetailInteractorProtocol, word: String) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.word = word
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoadingView()
        view?.setTableView()
        view?.setSynonymCollectionView()
        view?.setFilterCollectionView()
        setTimer()
        interactor.fetchWord(with: word)
        interactor.fetchWordSynonym(with: word)
    }
    
    func numberOfSections() -> Int {
        meaningsForSelectedPartOfSpeech().count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        meaningsForSelectedPartOfSpeech()[section].definitions?.count ?? 0
    }
    
    func meaningForSection(_ section: Int) -> WordData.Meanings {
        return meaningsForSelectedPartOfSpeech()[section]
    }
    
    func tapPlaySound() {
        if let audioURL = audioURL {
            view?.playAudio(from: audioURL)
        }
    }
    
    func numberOfItemInSection() -> Int {
        wordSynonymData?.count ?? 0
    }
    
    func synonymForSection(_ section: Int) -> String {
        wordSynonymData![section]
    }
    
    func didSelectSynonym(_ synonym: String) {
        CoreDataManager.shared.saveWord(recent: synonym)
        router.navigateToSynonymDetail(synonym)
    }
    
    func filterItems() -> Int {
        wordData?.meanings?.count ?? 0
    }
    
    func cellForFilter(_ index: IndexPath) -> String {
        wordData?.meanings?[index.item].partOfSpeech ?? ""
    }
    
    func filterByPartOfSpeech(_ partOfSpeech: String?,_ indexPath: IndexPath) {
        guard let partOfSpeech = partOfSpeech else { return }

        if let index = selectedPartOfSpeech.firstIndex(of: partOfSpeech) {
            selectedPartOfSpeech.remove(at: index)
            selectedFilterIndexes.remove(at: index)
        } else {
            selectedPartOfSpeech.append(partOfSpeech)
            selectedFilterIndexes.append(indexPath)
        }
        view?.reloadData()
    }
    
    func getSelectedFilterIndexes() -> [IndexPath] {
        return selectedFilterIndexes
    }
    
    func meaningsForSelectedPartOfSpeech() -> [WordData.Meanings] {
        
        guard !selectedPartOfSpeech.isEmpty, let meanings = wordData?.meanings else {
            return wordData?.meanings ?? []
        }
        return meanings.filter { selectedPartOfSpeech.contains($0.partOfSpeech ?? "") }
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(handleTimeout), userInfo: nil, repeats: false)
    }
    
    @objc private func handleTimeout() {
        view?.hideLoadingView()
        view?.showErrorAlertAndPop()
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchWordOutputs(_ wordData: WordData) {
        timer?.invalidate()
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
        view?.hideLoadingView()
        view?.reloadData()
    }
    
    func fethcWordSynonymOutputs(_ wordSynonymData: [WordSynonymData]) {
        let allSynonymData = wordSynonymData
        let sortedSynonymData = allSynonymData.sorted { ($0.score ?? 0) > ($1.score ?? 0) }
        self.wordSynonymData = sortedSynonymData.prefix(5).compactMap { $0.word }
        view?.reloadData()
    }
}
