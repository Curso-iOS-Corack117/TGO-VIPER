//
//  SidebarRectangleButtonView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 08/03/23.
//

import UIKit

class SidebarRectangleButtonView: SidebarButtonView {
    private var activeLayer: CALayer?
    private let borderWidth: CGFloat = 10
    var active: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if active {
            self.addActiveStyle()
            active = false
        }
    }
    
    override func setupView() {
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = UIColor(named: "lightGray-elektra")
        
        imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        
        image = image.withAlignmentRectInsets(
            .init(top: 0, left: -borderWidth, bottom: 0, right: 0)
        )
        setImage(image, for: .normal)
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    override func actionButton() {
        super.actionButton()
        delegate?.changeActiveView(active: self)
    }
    
    func addActiveStyle() {
        DispatchQueue.main.async { [self] in
            UIView.animate(withDuration: 0) { [self] in
                activeLayer = CALayer()
                activeLayer!.backgroundColor = UIColor(named: "wine-elektra")?.cgColor
                activeLayer!.frame = CGRect(
                    x: bounds.minX,
                    y: bounds.minY,
                    width: borderWidth,
                    height: bounds.height
                )
                layer.addSublayer(activeLayer!)
                backgroundColor = UIColor(named: "red-elektra")
                imageView?.tintColor = .white
                opacityAnimation()
            }
        }
    }
    
    func opacityAnimation(duration: TimeInterval = 0.2) {
        // created circularProgressAnimation with keyPath
        let animation = CABasicAnimation(keyPath: "opacity")
        // set the end time
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "animation")
    }
    
    func removeActiveStyle() {
        DispatchQueue.main.async { [self] in
            UIView.animate(withDuration: 0) { [self] in
                backgroundColor = .clear
                imageView?.tintColor = UIColor(named: "lightGray-elektra")
                activeLayer?.removeFromSuperlayer()
                layer.removeAllAnimations()
            }
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct SidebarRectangleButtonView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        SidebarRectangleButtonView(
            imageName: "bell.badge",
            isSystemImage: true,
            action: {}
        ).showPreview()
            .frame(
                minWidth: 70,
                maxWidth: 70,
                minHeight: 70,
                maxHeight: 70,
                alignment: .center
            )
            .previewLayout(.fixed(width: 100, height: 100))
            .ignoresSafeArea()
    }
}
#endif

