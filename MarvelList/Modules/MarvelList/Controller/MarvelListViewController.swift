//
//  MarvelListMarvelListViewController.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

class MarvelListViewController: UIViewController {

    var presenter: MarvelListControllerDelegate?
    
    @IBOutlet private weak var comicsTableView: UITableView!
    @IBOutlet private weak var characterCollectionView: UICollectionView!
    @IBOutlet private weak var characterActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var comicsActivityIndicator: UIActivityIndicatorView!
    
    private var characterModel = [CharacterListModel]()
    private var comicsModel = [ComicsListModel]()
    
    // MARK: - Load view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterCollectionView.allowsMultipleSelection = false
        characterCollectionView.allowsSelection = true
       
        presenter?.didReadyToWork()
    }
}

// MARK: - UICollectionViewDelegate

extension MarvelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCharacterItem(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == characterModel.count {
            presenter?.shouldLoadNextCharacterPage()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MarvelListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter?.charactersCountForDataSource() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == characterModel.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PaginationCharacterCell.self), for: indexPath)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCell.self), for: indexPath) as! CharacterCell
        cell.setData(characterModel[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDataSource

extension MarvelListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.comicsCountForDataSource() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == comicsModel.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PaginationComicsCell.self), for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ComicsCell.self), for: indexPath) as! ComicsCell
        cell.setData(comicsModel[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MarvelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == comicsModel.count {
            presenter?.shouldLoadNextComicsPage()
        }
    }
}

// MARK: - MarvelListControllerInterface

extension MarvelListViewController: MarvelListControllerInterface {
    func showComicsActivityIndicator() {
        DispatchQueue.main.async {  [weak self] in
            self?.comicsActivityIndicator.startAnimating()
            self?.comicsActivityIndicator.isHidden = false
            self?.characterCollectionView.isUserInteractionEnabled = false
        }
    }
    
    func hideComicsActivityIndicator() {
        DispatchQueue.main.async {  [weak self] in
            self?.comicsActivityIndicator.stopAnimating()
            self?.comicsActivityIndicator.isHidden = true
            self?.characterCollectionView.isUserInteractionEnabled = true
        }
    }
    
    func updateComics(_ comics: [ComicsListModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.comicsModel = comics
            self?.comicsTableView.reloadData()
        }
    }
    
    func updateCharactersData(_ model: [CharacterListModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.characterModel = model
            self?.characterCollectionView.reloadData()
        }
    }
    
    func showCharacterActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.characterActivityIndicator.startAnimating()
            self?.characterActivityIndicator.isHidden = false
        }

    }
    
    func hideCharacterActivityIndicator() {
        DispatchQueue.main.async {  [weak self] in
            self?.characterActivityIndicator.stopAnimating()
            self?.characterActivityIndicator.isHidden = true
        }
    }
    
    func showError(_ error: String) {
        // TODO: make showing errors
        DispatchQueue.main.async {  [weak self] in
            self?.characterCollectionView.isUserInteractionEnabled = true
        }
    }
}
