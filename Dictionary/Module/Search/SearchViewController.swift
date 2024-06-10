//
//  SearchViewController.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 9.06.2024.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func setupKeyboardObservers()
    func setupTapGesture()
    func setupSearchBar()
    func isSearchBarEmpty()
}

final class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        if let word = searchBar.text {
            presenter.searchButtonTapped(with: word)
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: 0.3) {
            self.searchButtonBottomConstraint.constant = keyboardHeight + 10
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.searchButtonBottomConstraint.constant = 20
            self.view.layoutIfNeeded()
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = .search
    }
    
    func isSearchBarEmpty() {
        searchButton.isEnabled = false
        searchBar.enablesReturnKeyAutomatically = true
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarHasText = !searchText.isEmpty
        searchButton.isEnabled = searchBarHasText
        searchBar.enablesReturnKeyAutomatically = true
    }
}
