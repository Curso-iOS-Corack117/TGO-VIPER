//
//  SidebarPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import Foundation

protocol SidebarViewUI: AnyObject {
    func updateView() -> Void
}

protocol SidebarViewPresentable: AnyObject {
    var viewUI: SidebarViewUI? { get }
    var viewType: ViewTypes { get set }
    var sidebarWidth: CGFloat { get set }
}

internal enum ViewTypes {
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
    var sidebarWidth: CGFloat {
        didSet {
            if let view = viewUI {
                view.updateView()
            }
        }
    }
    
    init() {
        self.sidebarWidth = SidebarView.getSidebarWidth()
    }
}
