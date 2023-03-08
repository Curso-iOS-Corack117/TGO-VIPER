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
        stack.spacing = 8
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    lazy var container: UIView = {
        let container = UIView(frame: .zero)
        return container
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
            let pdvWidget = PDVCardWidgetView(widgetSize: frame.width - 30)
            pdvWidget.presenter = PDVCardWidgetPresenter(viewUI: pdvWidget, id: 0)
            pdvWidget.stackWidgetDelegate = presenter
            vstack.addArrangedSubview(pdvWidget)
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
        
        backgroundColor = UIColor(named: "white-gray")
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

