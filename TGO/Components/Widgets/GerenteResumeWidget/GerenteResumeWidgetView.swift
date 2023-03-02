//
//  GerenteResumeWidgetView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 27/02/23.
//

import UIKit

class GerenteResumeWidgetView: UIView {
    
    lazy var pdvName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 40)
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    
    lazy var employeeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var noEmployeeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var vstackEmployee: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [employeeLabel, noEmployeeLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 0
        return stack
    }()
    
    lazy var vstack: UIStackView = {
        let vstack = UIStackView(arrangedSubviews: [pdvName, imageView, vstackEmployee])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .equalSpacing
        vstack.spacing = 10
        return vstack
    }()
    
    private let widgetSize: CGFloat

    init(widgetSize: CGFloat) {
        self.widgetSize = widgetSize
        super.init(frame: .zero)
        self.setupView()
        self.updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializer la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = (frame.width * 0.45) / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "red-elektra")?.cgColor
        imageView.layer.masksToBounds = true
    }

    private func setupView() {
        addSubview(vstack)
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(widgetSize)
        }
        
        vstack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        pdvName.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(self).multipliedBy(0.16)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(widgetSize * 0.45)
        }
        
        employeeLabel.snp.makeConstraints { make in
            make.width.equalTo(widgetSize * 0.9)
            make.height.equalTo(widgetSize / 10)
        }
        
        noEmployeeLabel.snp.makeConstraints { make in
            make.width.equalTo(widgetSize * 0.25)
        }
        
        clipsToBounds = true
    }
    
    func updateView() {
        pdvName.text = "172 TSA Mega Villa Olímpica"
        if let uiimage = UIImage(named: "sergio") {
            imageView.image = uiimage
        }
        employeeLabel.text = "Sergio Ordaz Romero"
        noEmployeeLabel.text = "1067221"
    }
}


#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct GerenteResumeWidgetView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        GerenteResumeWidgetView(widgetSize: 150).showPreview()
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
