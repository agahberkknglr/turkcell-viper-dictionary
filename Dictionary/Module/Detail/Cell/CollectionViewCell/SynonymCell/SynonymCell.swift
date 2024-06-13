//
//  SynonymCell.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import UIKit

protocol SynonymCellProtocol: AnyObject {
    func setSynonym(_ text: String)
}

class SynonymCell: UICollectionViewCell {
    
    static let identifier = "SynonymCell"

    @IBOutlet weak var synonymlabel: UILabel!
    
    var cellPresenter: SynonymCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension SynonymCell: SynonymCellProtocol {
    func setSynonym(_ text: String) {
        synonymlabel.text = text
        synonymlabel.layer.cornerRadius = 15
        synonymlabel.layer.borderWidth = 1
        synonymlabel.textColor = UIColor.label
        synonymlabel.layer.borderColor = UIColor.label.cgColor
        //synonymlabel.clipsToBounds = true
    }
}
