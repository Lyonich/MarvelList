//
//  MarvelListMarvelListHeader.swift
//  MarvelList
//
//  Created by Lyonich on 21/07/2021.
//  Copyright 2021 Home. All rights reserved.
//

import UIKit

class MarvelListHeader: NSObject {

    weak var controller: MarvelListViewController!

    init(root: MarvelListDelegate) {
        super.init()

        let presenter = MarvelListPresenter()
        let interactor = MarvelListInteractor()
        controller = moduleController()

        presenter.root = root
        presenter.controller = controller
        presenter.interactor = interactor

        controller.presenter = presenter
        interactor.presenter = presenter
    }

    func currentController() -> UIViewController {
        return controller
    }

    // MARK: - private

    private func moduleController() -> MarvelListViewController {
        return moduleStoryboard().instantiateViewController(withIdentifier: "MarvelListViewController") as! MarvelListViewController
    }

    private func moduleStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "MarvelList", bundle: nil)
    }
}

extension MarvelListHeader: MarvelListInterface {

}
