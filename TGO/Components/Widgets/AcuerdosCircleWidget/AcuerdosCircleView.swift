//
//  AcuerdosCircleView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class AcuerdosCircleView: UIView {
    
    lazy var content: UIView = {
        let content = UIView(frame: .zero)
        return content
    }()
    
    lazy var title: LabelBottomBordered = {
        let title = LabelBottomBordered(frame: .zero, color: UIColor(named: "gs-orange"))
        title.text = "Acuerdos"
        title.textAlignment = .center
        title.textColor = .black
        title.font = .systemFont(ofSize: 18, weight: .medium)
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        return title
    }()
    
    lazy var circleProgress: CircleProgressBarView = {
        let progressBar = CircleProgressBarView(
            percentage: percentage,
            withSize: widgetSize * 0.8
        )
        return progressBar
    }()
    
    let percentage: CGFloat
    let widgetSize: CGFloat
    
    init(percentage: CGFloat, widgetSize: CGFloat) {
        self.percentage = percentage
        self.widgetSize = widgetSize
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        content.layer.cornerRadius = content.frame.width / 16
    }
    
    func setupView() {
        addSubview(content)
        content.addSubview(title)
        content.addSubview(circleProgress)
        
        content.backgroundColor = UIColor(named: "gray-elektra")
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(widgetSize)
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        circleProgress.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct AcuerdosCircleView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        AcuerdosCircleView(percentage: 85, widgetSize: 150).showPreview()
            .ignoresSafeArea()
            .frame(
                minWidth: 150,
                maxWidth: 150,
                minHeight: 150,
                maxHeight: 150,
                alignment: .center
            )
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
#endif

