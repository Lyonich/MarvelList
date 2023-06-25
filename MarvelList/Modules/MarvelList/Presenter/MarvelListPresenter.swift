//
//  MarvelListMarvelListPresenter.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

class MarvelListPresenter: NSObject {
    private var charactersApiModel: CharacterAPIModel?
    private var characterModel =  [CharacterListModel]()
    
    private var comicsApiModel: ComicsAPIModel?
    private var comicsModel = [ComicsListModel]()
    
    var interactor: MarvelListInteractorInterface?
    weak var root: MarvelListDelegate?
    weak var controller: MarvelListControllerInterface?
}

// MARK: - MarvelListInterface

extension MarvelListPresenter: MarvelListInterface {

}

// MARK: - MarvelListControllerDelegate

extension MarvelListPresenter: MarvelListControllerDelegate {
    func comicsCountForDataSource() -> Int {
        if comicsModel.count % Constants.pageSize == 0 && comicsModel.count > 0  {
            return comicsModel.count + 1
        }
        
        return comicsModel.count
    }
    
    func charactersCountForDataSource() -> Int {
        if characterModel.count % Constants.pageSize == 0 && characterModel.count > 0  {
            return characterModel.count + 1
        }
        
        return characterModel.count
    }
    
    func shouldLoadNextComicsPage() {
        guard let selectedId = characterModel.filter( { $0.isSelected }).first?.id else {
            return
        }
        
        interactor?.loadAllComics(for: selectedId, offset: comicsModel.count)
    }
    
    func shouldLoadNextCharacterPage() {
        interactor?.updateCharacterData(offset: characterModel.count)
    }
    
    func didSelectCharacterItem(_ index: Int) {
        comicsModel = [ComicsListModel]()
        controller?.updateComics(comicsModel)
        
        controller?.showComicsActivityIndicator()
        
        characterModel.forEach({ $0.isSelected = false })
        characterModel[index].isSelected = true
     
        controller?.updateCharactersData(characterModel)
        
        interactor?.loadAllComics(for: characterModel[index].id, offset: comicsModel.count)
    }
    
    func didReadyToWork() {
        controller?.showCharacterActivityIndicator()
        controller?.hideComicsActivityIndicator()
        interactor?.updateCharacterData(offset: characterModel.count)
    }
}

// MARK: - MarvelListInteractorDelegate

extension MarvelListPresenter: MarvelListInteractorDelegate {
    func didGetComicsData(_ data: ComicsAPIModel) {
        self.comicsApiModel = data
    }
    
    func didCompleteDownloadAllCovers(covers: [UIImage]) {
        guard let apiModel = comicsApiModel else {
            //model creation order error
            return
        }
        
        guard covers.count == apiModel.data.results.count else {
            //quantity mismatch error
            return
        }
        
        var comicsItems = [ComicsListModel]()
        
        for (i, element) in apiModel.data.results.enumerated() {
            comicsItems.append(ComicsListModel(title: element.title, cover: covers[i]))
        }
        
        comicsModel.append(contentsOf: comicsItems)
        
        controller?.hideComicsActivityIndicator()
        controller?.updateComics(comicsModel)
        
    }
    
    func didCompleteDownloadAllAvatars(avatars: [UIImage]) {
        guard let apiModel = charactersApiModel else {
            //model creation order error
            return
        }
        
        guard avatars.count == apiModel.data.results.count else {
            //quantity mismatch error
            return
        }

        var characterItems = [CharacterListModel]()
        
        for (i, element) in apiModel.data.results.enumerated() {
            characterItems.append(CharacterListModel(id: element.id, name: element.name, avatar: avatars[i], isSelected: false))
        }
        
        self.characterModel.append(contentsOf: characterItems)
        
        controller?.hideCharacterActivityIndicator()
        controller?.updateCharactersData(characterModel)
        
        if characterModel.count == 20 {
            didSelectCharacterItem(0)
        }
        
    }
    
    func didGetCharacterData(_ data: CharacterAPIModel) {
        self.charactersApiModel = data
    }
    
    func didGetError(_ error: Error) {
        controller?.showError(error.localizedDescription)
        controller?.hideCharacterActivityIndicator()
    }
    
}
