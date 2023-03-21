//
//  CircleButtonView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 17/03/23.
//

import UIKit

//Vista perteneciente al botón de acciones
class CircleButtonView: UIButton {
    
    private let image: UIImage?
    
    init(frame: CGRect, image: UIImage?) {
        self.image = image?.withRenderingMode(.alwaysTemplate)
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height /  2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
    
    private func setupView() {
        imageView?.tintColor = .white
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = .white
        //        addTarget(self, action: #selector(nil), for: .touchUpInside)
    }
}
