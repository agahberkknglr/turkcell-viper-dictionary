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
    func setTableView()
    func updateSearchHistory()
}

final class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setAccessibilityIdentifiers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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


//MARK: - Protocol Extension
extension SearchViewController: SearchViewControllerProtocol {
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        tableView.backgroundView?.addGestureRecognizer(tapGesture)
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
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RecentCell", bundle: nil), forCellReuseIdentifier: RecentCell.identifier)
        tableView.isUserInteractionEnabled = true
    }
    
    func updateSearchHistory() {
        tableView.reloadData()
    }
    
    func setAccessibilityIdentifiers() {
        searchBar.accessibilityIdentifier = "searchBar"
        searchButton.accessibilityIdentifier = "searchButton"
    }
    
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarHasText = !searchText.isEmpty
        searchButton.isEnabled = searchBarHasText
        searchBar.enablesReturnKeyAutomatically = true
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = presenter.cellForRowAt(indexPath.row)
        presenter.searchButtonTapped(with: word)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteRow(at: indexPath.row)
        }
    }
}


//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as! RecentCell
        let recent = presenter.cellForRowAt(indexPath.row)
        let cellPresenter = RecentCellPresenter(view: cell, recent: recent.capitalized)
        cell.cellPresenter = cellPresenter
        cell.selectionStyle = .default
        return cell
    }
}

//MARK: - UIGestureRecognizerDelegate
extension SearchViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
