//
//  SidebarPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import Foundation

protocol SidebarViewUI: AnyObject {
    func updateSidebarContraints() -> Void
}

protocol SidebarViewPresentable: AnyObject {
    var viewUI: SidebarViewUI? { get }
}

class SidebarViewPresenter: SidebarViewPresentable {
    weak var viewUI: SidebarViewUI?
    
    
}
