//
//  DetailViewController.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import UIKit
import AVFoundation

protocol DetailViewControllerProtocol: AnyObject {
    func setWordTitleLabel(with text: String)
    func setSynonymLabel(with text: String)
    func setTableView()
    func reloadData()
    func setupSoundButton(isEnabled: Bool)
    func playAudio(from url: URL)
    func setSynonymCollectionView()
    func setFilterCollectionView()
    func showLoadingView()
    func hideLoadingView()
    func showErrorAlertAndPop()
}

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    @IBOutlet weak var wordSynonymLabel: UILabel!
    @IBOutlet weak var wordAudioButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var synonymCollectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    
    var presenter: DetailPresenterProtocol!
    var word: String?
    private var player: AVPlayer?
    private var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setAccessibilityIdentifiers()
    }
    
    @IBAction func wordAudioButtonAction(_ sender: UIButton) {
        presenter.tapPlaySound()
    }
}

//MARK: - Protocol Extension
extension DetailViewController: DetailViewControllerProtocol {
    
    func setWordTitleLabel(with text: String) {
        DispatchQueue.main.async {
            self.wordTitleLabel.text = text.capitalized
        }
    }
    
    func setSynonymLabel(with text: String) {
        DispatchQueue.main.async {
            if text.isEmpty {
                self.wordSynonymLabel.isHidden = true
            }
            self.wordSynonymLabel.text = text
        }
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WordCell", bundle: nil), forCellReuseIdentifier: WordCell.identifier)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.synonymCollectionView.reloadData()
            self.filterCollectionView.reloadData()
        }
    }
    
    func setupSoundButton(isEnabled: Bool) {
        DispatchQueue.main.async {
            self.wordAudioButton.isEnabled = isEnabled
            self.wordAudioButton.isHidden = !isEnabled
        }
    }
    
    func playAudio(from url: URL) {
        DispatchQueue.main.async {
            self.player = AVPlayer(url: url)
            self.player?.play()
        }
    }
    
    func setSynonymCollectionView() {
        synonymCollectionView.dataSource = self
        synonymCollectionView.delegate = self
        synonymCollectionView.register(UINib(nibName: "SynonymCell", bundle: nil), forCellWithReuseIdentifier: SynonymCell.identifier)
    }
    
    func setFilterCollectionView() {
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: FilterCell.identifier)
    }
    
    func showLoadingView() {
        loadingView = LoadingView(frame: view.bounds)
        if let loadingView = loadingView {
            view.addSubview(loadingView)
            DispatchQueue.main.async {
                self.navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    func showErrorAlertAndPop() {
        stackView.isHidden = true
        let alert = UIAlertController(title: "No Definitions Found", message: "Sorry pal, we couldn't find definitions for the word you were looking for.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    //MARK: - TestIdentifier
    func setAccessibilityIdentifiers() {
        wordTitleLabel.accessibilityIdentifier = "wordTitleLabel"
        wordSynonymLabel.accessibilityIdentifier = "wordSynonymLabel"
        wordAudioButton.accessibilityIdentifier = "wordAudioButton"
        tableView.accessibilityIdentifier = "resultsTableView"
        filterCollectionView.accessibilityIdentifier = "filterCollectionView"
        synonymCollectionView.accessibilityIdentifier = "synonymCollectionView"
    }
}

//MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as! WordCell
        let meaning = presenter.meaningForSection(indexPath.section)
        let definition = meaning.definitions?[indexPath.row].definition ?? ""
        let example = meaning.definitions?[indexPath.row].example ?? ""
        let cellPresenter = WordCellPresenter(view: cell, partOfSpeech: meaning.partOfSpeech ?? "", definition: definition, example: example , index: indexPath.row)
        cell.cellPresenter = cellPresenter
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.synonymCollectionView {
            let synonym = presenter.synonymForSection(indexPath.item)
            presenter.didSelectSynonym(synonym)
        } else {
            let filter = presenter.cellForFilter(indexPath)
            presenter.filterByPartOfSpeech(filter, indexPath)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.synonymCollectionView {
            return presenter.numberOfItemInSection()
        } else {
            return presenter.filterItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.synonymCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynonymCell.identifier, for: indexPath) as! SynonymCell
            let synonym = presenter.synonymForSection(indexPath.item)
            let cellPresenter = SynonymCellPresenter(view: cell, synonym: synonym)
            cell.cellPresenter = cellPresenter
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
            let filter = presenter.cellForFilter(indexPath)
            let cellPresenter = FilterCellPresenter(view: cell, filter: filter)
            cell.cellPresenter = cellPresenter
            let isSelected = presenter.getSelectedFilterIndexes().contains(indexPath)
            cell.filterLabelIsSelected(isSelected)
            return cell
        }
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.synonymCollectionView {
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)
        } else {
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5) 
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.synonymCollectionView {
            return 4
        } else {
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.synonymCollectionView {
            return 8
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.synonymCollectionView {
            let collectionViewWidth = synonymCollectionView.frame.width
            let collectionViewHeight = synonymCollectionView.frame.width
            let cellWidth = (collectionViewWidth - 15 ) / 3
            let cellHeight = cellWidth / 2.5 
            return CGSize(width: cellWidth , height: cellHeight)
        }
        else {
            let collectionViewWidth = filterCollectionView.frame.width
            let collectionViewHeight = filterCollectionView.frame.width
            let cellWidth = (collectionViewWidth - 15 ) / 3
            let cellHeight = cellWidth / 2.5
            return CGSize(width: cellWidth , height: cellHeight)
        }
    }
}
