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
    func setExampleLabel(_ text: String)
}

class WordCell: UITableViewCell {
    
    static let identifier = "WordCell"

    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleTitleLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
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
        
        var capilizedText = text
        
        let components = text.components(separatedBy: " - ")
        var capitalizedComponents = components.map { $0.capitalized }
        capilizedText = capitalizedComponents.joined(separator: " - ")
        
        let attributedText = NSMutableAttributedString(string: capilizedText)
        if let range = text.range(of: " -") {
            let numberRange = NSRange(location: 0, length: range.lowerBound.utf16Offset(in: capilizedText))
            attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: numberRange)
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: numberRange)
            
            let wordStartIndex = text.index(after: range.upperBound)
            let wordRange = NSRange(location: wordStartIndex.utf16Offset(in: capilizedText), length: capilizedText.count - wordStartIndex.utf16Offset(in: capilizedText))
            attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: wordRange)
            attributedText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 24), range: wordRange)
        }
        
        self.partOfSpeechLabel.attributedText = attributedText
    }
    
    func setDefinitionLabel(_ text: String) {
        self.definitionLabel.text = text
    }
    
    
    func setExampleLabel(_ text: String) {
        if text.isEmpty {
            exampleLabel.isHidden = true
            exampleTitleLabel.isHidden = true
        } else {
            exampleLabel.isHidden = false
            exampleTitleLabel.isHidden = false
            self.exampleLabel.text = text
        }
    }
}
