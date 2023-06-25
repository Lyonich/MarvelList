//
//  MarvelListMarvelListInteractor.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

class MarvelListInteractor: NSObject {
    
    private let apiClient = APIClient()
    weak var presenter: MarvelListInteractorDelegate?
    
    private var nsCache = NSCache<NSString, UIImage>()
    private let imageDownloadGroup = DispatchGroup()
    
}

// MARK: - MarvelListInteractorInterface

extension MarvelListInteractor: MarvelListInteractorInterface {
    func loadAllComics(for id: Int, offset: Int) {
        let resource = Resource(url: APIEnpoints.allComics(id: id).path, offset: offset)
        
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(ComicsAPIModel.self, from: data)
                    print(items)
                    self.presenter?.didGetComicsData(items)
                    let urls = items.data.results.compactMap( { URL(string: $0.thumbnail.path + "." + $0.thumbnail.extensionImage)!  })

                    self.downloadAllImages(urls) { images in
                        self.presenter?.didCompleteDownloadAllCovers(covers: images)
                    }
                } catch {
                    self.presenter?.didGetError(error)
                }
            case .failure(let error):
                self.presenter?.didGetError(error)
            }
        }
    }
    
    func updateCharacterData(offset: Int) {
        let resource = Resource(url: APIEnpoints.allCharacters.path, offset: offset)
        
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(CharacterAPIModel.self, from: data)
                    self.presenter?.didGetCharacterData(items)
                    
                    let urls = items.data.results.compactMap( { URL(string: $0.thumbnail.path + "." + $0.thumbnail.extensionImage)!  })
                    
                    self.downloadAllImages(urls) { images in
                        self.presenter?.didCompleteDownloadAllAvatars(avatars: images)
                    }
                } catch {
                    self.presenter?.didGetError(error)
                }
            case .failure(let error):
                self.presenter?.didGetError(error)
            }
        }
    }
    
    func downloadAllImages(_ urls: [URL], completion: @escaping ([UIImage]) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let semaphore = DispatchSemaphore(value: 5)
            var imageDictionary: [URL: UIImage] = [:]
            
            for url in urls {
                self.imageDownloadGroup.enter()
                semaphore.wait()
                
                if let cashedImage = self.nsCache.object(forKey: url.absoluteString as NSString) {
                    DispatchQueue.main.async {
                        imageDictionary[url] = cashedImage
                    }
                    
                    semaphore.signal()
                    self.imageDownloadGroup.leave()
                } else {
                    APIClient().loadImage(URL: url) { result in
                        defer {
                            semaphore.signal()
                            self.imageDownloadGroup.leave()
                        }
                        
                        switch result {
                        case .failure(let error):
                            print(error)

                        case .success(let imageData):
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                imageDictionary[url] = image
                                
                                if let casheImage = image {
                                    self.nsCache.setObject(casheImage, forKey: url.absoluteString as NSString)
                                }
                            }
                        }
                    }
                }
            }

            self.imageDownloadGroup.notify(queue: .main) {
                completion(urls.compactMap { imageDictionary[$0] })
            }
        }
    }
}
