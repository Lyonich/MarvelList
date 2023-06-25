//
//  MarvelListMarvelListInteractorIO.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

protocol MarvelListInteractorInterface: AnyObject {
    func updateCharacterData(offset: Int)
    func loadAllComics(for id: Int, offset: Int)
}

protocol MarvelListInteractorDelegate: AnyObject {
    func didGetCharacterData(_ data: CharacterAPIModel)
    func didGetComicsData(_ data: ComicsAPIModel)
    func didCompleteDownloadAllAvatars(avatars: [UIImage])
    func didCompleteDownloadAllCovers(covers: [UIImage])
    func didGetError(_ error: Error)
}
