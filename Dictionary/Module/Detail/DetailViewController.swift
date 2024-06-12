//
//  DetailViewController.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setWordTitleLabel(with text: String)
    func setSynonymLabel(with text: String)
    func setTableView()
    func reloadData()

}

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    @IBOutlet weak var wordSynonymLabel: UILabel!
    @IBOutlet weak var wordAudioButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: DetailPresenterProtocol!
    var word: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func setWordTitleLabel(with text: String) {
        DispatchQueue.main.async {
            self.wordTitleLabel.text = text.capitalized
        }
    }
    
    func setSynonymLabel(with text: String) {
        DispatchQueue.main.async {
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
        }
    }
}

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
        let cellPresenter = WordCellPresenter(view: cell, partOfSpeech: meaning.partOfSpeech ?? "", definition: definition)
        cell.cellPresenter = cellPresenter
        return cell

    }
    
    
}
