//
//  EnterProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol EnterModuleInput {
	var moduleOutput: EnterModuleOutput? { get }
}

protocol EnterModuleOutput: class {
}

protocol EnterViewInput: class {
}

protocol EnterViewOutput: class {
}

protocol EnterInteractorInput: class {
}

protocol EnterInteractorOutput: class {
}

protocol EnterRouterInput: class {
}
