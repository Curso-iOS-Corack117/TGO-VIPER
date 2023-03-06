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
            radius: (frame.height - lineWidth) / 2,
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
        circleLayer.strokeColor = UIColor.white.cgColor
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
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "\(percentage)%"
        label.textColor = .black
        return label
    }()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private let lineWidth: CGFloat
    private let withSize: CGFloat
    private let percentage: CGFloat
    
    init(percentage: CGFloat, withSize: CGFloat) {
        self.percentage = percentage
        self.withSize = withSize
        self.lineWidth = withSize * 0.06
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        layer.position = CGPointMake(frame.midX, layer.frame.midY)
        
        progressAnimation(duration: 1)
    }
    
    func setupView() {
        addSubview(percentageLabel)
        
        percentageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func progressAnimation(duration: TimeInterval) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = percentage / 100
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
        CircleProgressBarView(percentage: 85, withSize: 150).showPreview()
            .ignoresSafeArea()
            .frame(
                minWidth: 150,
                maxWidth: 150,
                minHeight: 150,
                maxHeight: 150,
                alignment: .center
            )
            .previewLayout(.fixed(width: 150, height: 150))
    }
}
#endif
