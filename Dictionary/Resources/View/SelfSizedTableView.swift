//
//  SelfSizedTableView.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import UIKit

final class SelfSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
