//
//  CircleProgressBar.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class CircleProgressBarView: UIView {

    lazy var circularPath: UIBezierPath = {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0
            ),
            radius: (frame.width - lineWidth) / 2,
            startAngle: startPoint,
            endAngle: endPoint, clockwise: true
        )
        return circularPath
    }()
    
    lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.gray.cgColor
        return circleLayer
    }()
    
    lazy var progressLayer: CAShapeLayer = {
        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.orange.cgColor
        return progressLayer
    }()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private let lineWidth: CGFloat
    
    init(withSize: CGFloat) {
        self.lineWidth = withSize * 0.06
        super.init(frame: CGRect(
            origin: .zero,
            size: .init(width: withSize, height: withSize)
        ))
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    func setupView() {
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        layer.position = CGPointMake(layer.bounds.midX, layer.bounds.midY)
        
        progressAnimation(duration: 1)
    }
    
    func progressAnimation(duration: TimeInterval) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}


#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct CircleProgressBarView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        CircleProgressBarView(withSize: 150).showPreview()
            .ignoresSafeArea()
            .previewLayout(.fixed(width: 150, height: 150))
    }
}
#endif
