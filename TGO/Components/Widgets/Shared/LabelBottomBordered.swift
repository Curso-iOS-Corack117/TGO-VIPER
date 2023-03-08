//
//  LabelBottomBordered.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 06/03/23.
//

import UIKit

class LabelBottomBordered: UILabel {
    
    private let color: UIColor?
    
    init(frame: CGRect, color: UIColor?) {
        self.color = color
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let border = CALayer()
        let heightBorder: CGFloat = 2
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(
            x: bounds.minX,
            y: bounds.maxY,
            width: bounds.width,
            height: heightBorder
        )
        layer.addSublayer(border)
        print("frame")
        print(frame)
        print(frame.minX)
    }
}
