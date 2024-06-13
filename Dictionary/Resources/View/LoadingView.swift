//
//  LoadingView.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import UIKit

class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityInticator = UIActivityIndicatorView(style: .large)
        activityInticator.translatesAutoresizingMaskIntoConstraints = false
        return activityInticator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.systemBackground
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
}
