//
//  MarvelListMarvelListControllerIO.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import Foundation

protocol MarvelListControllerInterface: AnyObject {
    func updateCharactersData(_ model: [CharacterListModel])
    func updateComics(_ comics: [ComicsListModel])
    func showError(_ error: String)
    
    func showCharacterActivityIndicator()
    func hideCharacterActivityIndicator()
    
    func showComicsActivityIndicator()
    func hideComicsActivityIndicator()
}

protocol MarvelListControllerDelegate: AnyObject {
    func didReadyToWork()
    func didSelectCharacterItem(_ index: Int)
    
    func shouldLoadNextCharacterPage()
    func shouldLoadNextComicsPage()
    
    func charactersCountForDataSource() -> Int
    func comicsCountForDataSource() -> Int
}
