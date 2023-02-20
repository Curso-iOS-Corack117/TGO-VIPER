//
//  AcuerdosCircleView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class AcuerdosCircleView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Acuerdos"
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 24, weight: .medium)
        return title
    }()
    
    lazy var circleProgress: CircleProgressBarView = {
        let progressBar = CircleProgressBarView(withSize: widgetSize)
        return progressBar
    }()
    
    let widgetSize: CGFloat
    
    init(widgetSize: CGFloat) {
        self.widgetSize = widgetSize * 0.75
        super.init(frame: .init(origin: .zero, size: .init(width: widgetSize, height: widgetSize)))
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    func setupView() {
        addSubview(title)
        addSubview(circleProgress)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        circleProgress.snp.makeConstraints { make in
            make.width.height.equalTo(widgetSize)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.backgroundColor = .white
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct AcuerdosCircleView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        AcuerdosCircleView(widgetSize: 150).showPreview()
            .ignoresSafeArea()
            .previewLayout(.fixed(width: 150, height: 150))
    }
}
#endif

