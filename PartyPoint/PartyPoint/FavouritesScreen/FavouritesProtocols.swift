//
//  FavouritesProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol FavouritesModuleInput {
	var moduleOutput: FavouritesModuleOutput? { get }
}

protocol FavouritesModuleOutput: AnyObject {
}

protocol FavouritesViewInput: AnyObject {
}

protocol FavouritesViewOutput: AnyObject {
}

protocol FavouritesInteractorInput: AnyObject {
}

protocol FavouritesInteractorOutput: AnyObject {
}

protocol FavouritesRouterInput: AnyObject {
}
