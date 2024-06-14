//
//  FilterCell.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import UIKit

protocol FilterCellProtocol: AnyObject {
    func setfilterLabel(_ filter: String)
    func filterLabelIsSelected(_ isSelected: Bool)
}

final class FilterCell: UICollectionViewCell {
    
    static let identifier = "FilterCell"

    @IBOutlet weak var filterLabel: UILabel!
    
    var cellPresenter: FilterCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension FilterCell: FilterCellProtocol {
    func setfilterLabel(_ filter: String) {
        filterLabel.text = filter.capitalized
        filterLabel.layer.cornerRadius = 15
        filterLabel.layer.borderWidth = 1
        filterLabel.textColor = UIColor.label
        filterLabel.layer.borderColor = UIColor.label.cgColor
        filterLabel.backgroundColor = UIColor.systemGray5
    }
    
    func filterLabelIsSelected(_ isSelected: Bool) {
        if isSelected {
            filterLabel.layer.borderColor = UIColor(red:0/255, green:0/255, blue:255/255, alpha: 1).cgColor
        }
        else {
            filterLabel.layer.borderColor = UIColor.label.cgColor
        }
        
    }
}
