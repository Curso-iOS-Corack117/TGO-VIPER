//
//  SidebarPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import Foundation

protocol SidebarUI: AnyObject {
    var sidebarContent: SidebarContentView { get set }
    func updateView() -> Void
}

protocol SidebarButtonUI: AnyObject {
    var imageName: String { get set }
    var action: () -> Void { get }
    var isSystemImage: Bool { get set }
}

protocol SidebarPresentable: AnyObject {
    var viewUI: SidebarUI? { get }
    var viewType: ViewTypes { get set }
    var sidebarWidth: CGFloat { get set }
    func changeActiveView(active: SidebarButtonUI) -> Void
}

internal enum ViewTypes {
    case home
    case agenda
    case dashboard
    case visita_pdv
    case chat_zeus
    case ayuda
}

class SidebarPresenter: SidebarPresentable {
    
    weak var viewUI: SidebarUI?
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
    
    func changeActiveView(active: SidebarButtonUI) {
        if let activeButton = active as? SidebarRectangleButtonView {
            viewUI?.sidebarContent.viewButtons.arrangedSubviews.forEach {
                if let button = $0 as? SidebarRectangleButtonView {
                    button.removeActiveStyle()
                    if button == activeButton {
                        button.addActiveStyle()
                    }
                }
            }
        }
    }
}
