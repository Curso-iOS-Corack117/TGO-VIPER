//
//  PDVCardWidgetView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 27/02/23.
//

import UIKit

class PDVStackWidgetView: UIView {
    
    lazy var vstack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    lazy var header: UIStackView = {
        let stack = UIStackView(frame: .zero)
        return stack
    }()
    
    private var firstTime = true
    private let sizeHeader: CGFloat = 30
    
    var presenter: PDVStackWidgetPresenter? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    // Se ejecuta después de añadir las vistas
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstTime {
            for id in 0..<4 {
                let pdvWidget = PDVCardWidgetView(widgetSize: frame.width - 30)
                pdvWidget.presenter = PDVCardWidgetPresenter(viewUI: pdvWidget, id: id)
                pdvWidget.stackWidgetDelegate = presenter
                vstack.addArrangedSubview(pdvWidget)
            }
            firstTime = false
        }
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(vstack)
                
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "gray-elektra")
    }
}

extension PDVStackWidgetView: PDVStackWidgetViewUI {
    func updatePDV() {
        
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct PDVStackWidget_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        PDVStackWidgetView().showPreview()
            .ignoresSafeArea()
            .previewLayout(.fixed(width: 800, height: 1200))
    }
}
#endif

