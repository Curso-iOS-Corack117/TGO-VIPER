//
//  ExpandButtonView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 17/03/23.
//

import UIKit

//Vista perteneciente al botón de expansión
class ExpandButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height /  4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    private func setupView() {
        var image = UIImage(named: "arrow.up.left.and.arrow.down.right")
        image = UIImage(cgImage: (image?.cgImage)!, scale: 1, orientation: .left)
        imageView?.tintColor = .black
        imageView?.layer.masksToBounds = false
        //        imageView?.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        
        imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = .white
        //        addTarget(self, action: #selector(nil), for: .touchUpInside)
    }
}
