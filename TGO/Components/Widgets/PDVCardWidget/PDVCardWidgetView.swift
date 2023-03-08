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
        var image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
        image = UIImage(cgImage: (image?.cgImage)!, scale: 1, orientation: .left)
        let expandButton = CircleButtonView(
            frame: .zero,
            image: image
        )
        expandButton.imageView?.tintColor = .black
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
    
    private var firstTime = true
    private var widgetSize: CGFloat
    
    var presenter: PDVCardWidgetPresenter? = nil
    var stackWidgetDelegate: PDVStackWidgetPresenter? = nil
    
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
extension PDVCardWidgetView: PDVCardWidgetViewUI {
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

//Vista perteneciente al botón de acciones
internal class CircleButtonView: UIButton {
    
    private let image: UIImage?
    
    init(frame: CGRect, image: UIImage?) {
        self.image = image
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
        imageView?.tintColor = .white
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = .white
//        addTarget(self, action: #selector(nil), for: .touchUpInside)
    }
}

//Vista perteneciente al botón de expansión
internal class ExpandButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height /  4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    private func setupView() {
        var image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
        image = UIImage(cgImage: (image?.cgImage)!, scale: 1, orientation: .left)
        imageView?.tintColor = .black
        imageView?.layer.masksToBounds = false
//        imageView?.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        
        imageView?.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        
        setImage(image, for: .normal)
        clipsToBounds = true
        backgroundColor = .white
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
