//
//  WordCell.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 10.06.2024.
//

import UIKit

protocol WordCellProtocol: AnyObject {
    func setPartOfSpeechLabel(_ text: String)
    func setDefinitionLabel(_ text: String)
}

class WordCell: UITableViewCell {
    
    static let identifier = "WordCell"

    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var cellPresenter: WordCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension WordCell: WordCellProtocol {
    func setPartOfSpeechLabel(_ text: String) {
        self.partOfSpeechLabel.text = text
    }
    
    func setDefinitionLabel(_ text: String) {
        self.definitionLabel.text = text
        print("Setting part of definiton label to: \(text)")
    }
}
