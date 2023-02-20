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
    var viewType: ViewTypes { get set }
}

enum ViewTypes {
    case home
    case agenda
    case dashboard
    case visita_pdv
    case chat_zeus
    case ayuda
}

class SidebarViewPresenter: SidebarViewPresentable {
    weak var viewUI: SidebarViewUI?
    var viewType: ViewTypes = .home
}
