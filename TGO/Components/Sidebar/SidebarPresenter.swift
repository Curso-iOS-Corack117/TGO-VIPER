//
//  SidebarPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import Foundation

protocol SidebarViewUI: AnyObject {
    var sidebarContent: SidebarContentView { get set }
    func updateView() -> Void
}

protocol SidebarButtonViewUI: AnyObject {
    var imageName: String { get set }
    var action: () -> Void { get }
    var isSystemImage: Bool { get set }
}

protocol SidebarViewPresentable: AnyObject {
    var viewUI: SidebarViewUI? { get }
    var viewType: ViewTypes { get set }
    var sidebarWidth: CGFloat { get set }
    func changeActiveView(active: SidebarButtonViewUI) -> Void
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
    
    func changeActiveView(active: SidebarButtonViewUI) {
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
