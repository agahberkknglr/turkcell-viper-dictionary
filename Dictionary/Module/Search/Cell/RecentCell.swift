//
//  RecentCell.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import UIKit

protocol RecentCellProtocol: AnyObject {
    func setRecentLabel(_ word: String)
}

final class RecentCell: UITableViewCell {
    
    static let identifier = "RecentCell"
    
    @IBOutlet weak var recentLabel: UILabel!
    
    var cellPresenter: RecentCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension RecentCell: RecentCellProtocol {
    func setRecentLabel(_ word: String) {
        recentLabel.text = word
    }
}
