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
//            SidebarButtonView(
//                imageName: "graph",
//                action: {
////                    self.manager.viewType = .dashboard
//                }
//            ),
//            SidebarButtonView(
//                imageName: "metro-shop",
//                action: {
////                    self.manager.viewType = .visita_pdv
//                }
//            ),
            UIView(frame: .zero),
            UIView(frame: .zero),
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
//            SidebarButtonView(
//                imageName: "charla",
//                action: {
////                    self.manager.viewType = .chat_zeus
//                }
//            ),
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
    
    lazy var container: UIView = {
        let container = UIView(frame: .zero)
        container.addSubview(vstack)
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let radius = frame.width / 3
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor(named: "white-gray")!.cgColor
        shapeLayer.masksToBounds = false
        
        layer.insertSublayer(shapeLayer, at: 0)
    }

    private func setupView() {
        addSubview(container)
        
        container.backgroundColor = .clear
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        vstack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.horizontalEdges.equalToSuperview()
            make.width.greaterThanOrEqualTo(40)
        }
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
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

