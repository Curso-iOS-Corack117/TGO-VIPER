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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if isSystemImage {
            return UIImage(systemName: imageName)!.withRenderingMode(.alwaysOriginal)
        } else {
            return UIImage(named: imageName) ?? UIImage()
        }
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

        self.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        setImage(image, for: .normal)
        backgroundColor = .orange
        layer.cornerRadius = 20
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    @objc private func actionButton() {
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
            .frame(width: 40, height: 40, alignment: .center)
            .ignoresSafeArea()
    }
}
#endif
