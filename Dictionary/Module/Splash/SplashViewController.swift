//
//  SplashViewController.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 7.06.2024.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    
}

final class SplashViewController: BaseViewController {

    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        presenter.viewDidAppear()
    }
    
}

extension SplashViewController: SplashViewControllerProtocol {
    
}
