//
//  SidebarButtonView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
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
    
    init(imageName: String = "", isSystemImage: Bool = false, action: @escaping () -> Void) {
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
        imageView?.tintColor = .white
        
        imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        

        self.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = UIColor(named: "red-elektra")
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    @objc private func actionButton() {
        action()
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct SidebarButtonView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        SidebarButtonView(
            imageName: "material-menu",
            action: {}
        ).showPreview()
            .frame(minWidth: 40, maxWidth: 40, minHeight: 40, maxHeight: 40, alignment: .center)
            .ignoresSafeArea()
    }
}
#endif
