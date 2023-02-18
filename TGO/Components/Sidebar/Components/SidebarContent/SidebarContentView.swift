//
//  SidebarContentView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import UIKit

class SidebarContentView: UIView {
    
    lazy var sidebarButtons: [UIView] = {
        let SidebarButtonViews = [
            SidebarButtonView(
                imageName: "material-menu",
                action: {
//                    self.manager.isOpened.toggle()
                }
            ),
            UIView(frame: .zero),
            SidebarButtonView(
                imageName: "material-home",
                action: {
//                    self.manager.viewType = .home
                }
            ),
            SidebarButtonView(
                imageName: "calendar-day",
                action: {
//                    self.manager.viewType = .agenda
                }
            ),
            SidebarButtonView(
                imageName: "graph",
                action: {
//                    self.manager.viewType = .dashboard
                }
            ),
            SidebarButtonView(
                imageName: "metro-shop",
                action: {
//                    self.manager.viewType = .visita_pdv
                }
            ),
            UIView(frame: .zero),
            UIView(frame: .zero),
            SidebarButtonView(
                imageName: "bell.badge",
                isSystemImage: true,
                action: {
//                    self.manager.isOpened = false
                    withAnimation(.spring()) {
//                        NotificationPaneManager.shared.isShow.toggle()
                    }
                }
            ),
            SidebarButtonView(
                imageName: "charla",
                action: {
//                    self.manager.viewType = .chat_zeus
                }
            ),
            SidebarButtonView(
                imageName: "open-question-mark",
                action: {
//                    self.manager.viewType = .ayuda
                }
            )
        ]
        return SidebarButtonViews
    }()
    
    lazy var vstack: UIStackView = {
        let vstack = UIStackView(arrangedSubviews: sidebarButtons)
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 20
        vstack.distribution = .equalCentering
        return vstack
    }()
    
    lazy var parentView: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.addSubview(vstack)
        return parentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }

    private func setupView() {
        addSubview(parentView)
        
        vstack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.horizontalEdges.equalToSuperview()
            make.width.greaterThanOrEqualTo(40)
        }
        
//        parentView.backgroundColor = UIColor(named: "white-gray")
        parentView.backgroundColor = .blue
        parentView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        vstack.clipsToBounds = true
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct SidebarContentView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        SidebarContentView()
            .showPreview()
            .frame(alignment: .center)
            .ignoresSafeArea()
    }
}
#endif

