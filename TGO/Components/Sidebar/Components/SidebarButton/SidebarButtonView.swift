//
//  SidebarButtonView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 08/03/23.
//

import UIKit

class SidebarButtonView: UIButton {
    var imageName: String = ""
    var action: () -> Void
    var isSystemImage: Bool = false
    
    lazy var image: UIImage = {
        var image: UIImage?
        if isSystemImage {
            image = UIImage(systemName: imageName)
        } else {
            image = UIImage(named: imageName)
        }
        image = image?.withTintColor(.white, renderingMode: .alwaysTemplate)
        return image ?? UIImage()
    }()
    
    var delegate: SidebarViewPresentable?
    
    init(imageName: String = "", isSystemImage: Bool = false, action: @escaping () -> Void = {}) {
        self.imageName = imageName
        self.isSystemImage = isSystemImage
        self.action = action
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    func setupView() {
        
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = .black
        
        imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        setImage(image, for: .normal)
        backgroundColor = .clear
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
}


// Implementación de protocolo SidebarButtonView
extension SidebarButtonView: SidebarButtonViewUI {
    @objc func actionButton() {
        action()
        print("hola")
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct SidebarButtonView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        SidebarButtonView(
            imageName: "bell.badge",
            isSystemImage: true,
            action: {}
        ).showPreview()
            .frame(
                minWidth: 40,
                maxWidth: 40,
                minHeight: 40,
                maxHeight: 40,
                alignment: .center
            )
            .previewLayout(.fixed(width: 100, height: 100))
            .ignoresSafeArea()
    }
}
#endif

