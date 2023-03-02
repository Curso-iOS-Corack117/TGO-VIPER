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
    
    lazy var addButton: AddButtonView = {
        let addButton = AddButtonView(frame: .zero)
        return addButton
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
    
    private var firstTime = true
    private var widgetSize: CGFloat
    
    init(widgetSize: CGFloat) {
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
            scrollContent.addArrangedSubview(ORCWidgetView(widgetSize: content.frame.height))
            scrollContent.addArrangedSubview(AcuerdosCircleView(
                percentage: 85,
                widgetSize: content.frame.height
            ))
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
        
        backgroundColor = .white
        addInteraction(UIDragInteraction(delegate: self))
        
//        Constrainsts
        self.snp.makeConstraints { make in
            make.width.equalTo(widgetSize)
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
        
        scrollView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        scrollContent.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

//Se conforma protocolo UIDragInteractionDelegate
extension PDVCardWidgetView: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
        print("start")
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let view = interaction.view as! Self
        let provider = NSItemProvider(object: <#T##NSItemProviderWriting#>)
        
        if let imageView = interaction.view as? UIImageView{
            guard let image = imageView.image else {return []}
            let provider = NSItemProvider(object: image)
            let item = UIDragItem.init(itemProvider: provider)
            return[item]
        }
        return []
    }
    
    
}

internal class AddButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height /  2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
    
    private func setupView() {
        let image = UIImage(systemName: "plus")
        imageView?.tintColor = .white
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = UIColor(named: "red-elektra")
//        addTarget(self, action: #selector(nil), for: .touchUpInside)
    }
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
