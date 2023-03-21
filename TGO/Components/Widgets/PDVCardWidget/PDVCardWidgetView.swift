//
//  PDVCardWidgetView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 22/02/23.
//

import UIKit

class PDVCardWidgetView: UIView {
    
    lazy var content: UIView = {
        let content = UIView(frame: .zero)
        return content
    }()
    
    lazy var addButton: CircleButtonView = {
        let addButton = CircleButtonView(frame: .zero, image: .init(systemName: "plus"))
        addButton.backgroundColor = UIColor(named: "red-elektra")
        return addButton
    }()
    
    lazy var expandButton: CircleButtonView = {
        var image = UIImage(named: "expand-icon")
        let expandButton = CircleButtonView(
            frame: .zero,
            image: .init(named: "expand-icon")
        )
        expandButton.imageView?.tintColor = .init(named: "lightGray-elektra")
        expandButton.backgroundColor = .init(named: "gray-elektra")
        expandButton.imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.4)
            make.center.equalToSuperview()
        }
        return expandButton
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    lazy var scrollContent: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    var widgetSize: CGFloat?
    private var firstTime = true
    
    var presenter: PDVCardWidgetPresenter? = nil
    var stackWidgetDelegate: PDVStackWidgetPresenter? = nil
    
    init(widgetSize: CGFloat? = nil) {
        self.widgetSize = widgetSize
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.cornerRadius = 10
        
        if firstTime {
            scrollContent.addArrangedSubview(GerenteResumeWidgetView(widgetSize: content.frame.height))
            scrollContent.addArrangedSubview(AcuerdosCircleView(
                percentage: 85,
                widgetSize: content.frame.height
            ))
            scrollContent.addArrangedSubview(ORCWidgetView(widgetSize: content.frame.height))
            firstTime = false
        }
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 50)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = true
    }
    
    func setupView() {
        addSubview(content)
        content.addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        content.addSubview(addButton)
        content.addSubview(expandButton)
        
        backgroundColor = .white
        addInteraction(UIDragInteraction(delegate: self))
        
//        Constrainsts
        self.snp.makeConstraints { make in
            if let horizontalSize = widgetSize {
                make.width.equalTo(horizontalSize)
            }
            make.height.equalTo(170)
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        addButton.snp.makeConstraints { make in
            let width = self.snp.height
            
            make.bottom.trailing.equalToSuperview()
            make.height.width.equalTo(width).multipliedBy(0.2)
        }
        
        expandButton.snp.makeConstraints { make in
            let width = self.snp.height
            
            make.top.trailing.equalToSuperview()
            make.height.width.equalTo(width).multipliedBy(0.2)
        }
        
        scrollView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        scrollContent.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

//Se conforma protocolo PDVCardWidgetViewUI
extension PDVCardWidgetView: PDVCardWidgetUI {
    func updateView() {
        
        
    }
}

//Se conforma protocolo UIDragInteractionDelegate
extension PDVCardWidgetView: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
        print("start")
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let view = interaction.view as! Self
        if let id = view.presenter?.id {
            let provider = NSItemProvider(contentsOf: URL(string: "\(id)"))!
            let item = UIDragItem(itemProvider: provider)
            return [item]
        }
        
        return []
    }
}

extension PDVCardWidgetView: UIDropInteractionDelegate {
    
}


#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct PDVCardWidgetView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        PDVCardWidgetView(widgetSize: 600).showPreview()
            .ignoresSafeArea()
            .frame(
                minHeight: 170,
                maxHeight: 170,
                alignment: .center
            )
            .previewLayout(.fixed(width: 600, height: 200))
    }
}
#endif
