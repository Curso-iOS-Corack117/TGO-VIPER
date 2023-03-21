//
//  SidebarContentView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import UIKit

class SidebarContentView: UIView {
    
    lazy var hamburguerButton: SidebarCircleButtonView = {
        let button = SidebarCircleButtonView(imageName: "material-menu")
        button.imageView?.tintColor = .init(named: "strongGray-elektra")
        button.layer.borderColor = UIColor(named: "strongGray-elektra")?.cgColor
        return button
    }()
    
    lazy var HomeButton: SidebarRectangleButtonView = {
        let button = SidebarRectangleButtonView(imageName: "material-home")
        button.active = true
        return button
    }()
    
    lazy var calendarButton = SidebarRectangleButtonView(imageName: "calendar-day")
    
    lazy var graphButton = SidebarRectangleButtonView(imageName: "graph")
    
    lazy var shopButton = SidebarRectangleButtonView(imageName: "metro-shop")
    
    lazy var questionButton: SidebarCircleButtonView = {
        let button = SidebarCircleButtonView(imageName: "open-question-mark")
        button.imageView?.tintColor = .init(named: "red-elektra")
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    lazy var viewButtons: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            HomeButton,
            calendarButton,
            graphButton,
            shopButton
        ])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 0
        return stack
    }()
    
    lazy var sidebarButtons: [UIView] = {
        let SidebarButtonViews = [
            hamburguerButton,
            UIView(frame: .zero),
            viewButtons,
            UIView(frame: .zero),
            SidebarButtonView(imageName: "bell.badge", isSystemImage: true),
//            SidebarButtonView(
//                imageName: "charla",
//                action: {
////                    self.manager.viewType = .chat_zeus
//                }
//            ),
            questionButton
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
        return container
    }()
    
    var delegate: SidebarPresentable?
    
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
        shapeLayer.fillColor = UIColor(named: "gray-elektra")!.cgColor
        shapeLayer.masksToBounds = false
        
        layer.insertSublayer(shapeLayer, at: 0)
    }

    private func setupView() {
        addSubview(container)
        container.addSubview(vstack)
        
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
    
    func setupButtons() {
        sidebarButtons.forEach {
            if let button = $0 as? SidebarButtonView {
                button.delegate = delegate
            }
        }
        
        viewButtons.arrangedSubviews.forEach {
            if let button = $0 as? SidebarRectangleButtonView {
                button.delegate = delegate
            }
        }
        
        viewButtons.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
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

