//
//  ORCWidgetView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 20/02/23.
//

import UIKit

class ORCWidgetView: UIView {
    
    lazy var content: UIView = {
        let content = UIView(frame: .zero)
//        content.layer.shadowColor = UIColor.black.cgColor
//        content.layer.shadowOpacity = 0.5
//        content.layer.masksToBounds = false
//        content.layer.shadowOffset = CGSize(width: -1, height: -1)
        content.layer.cornerRadius = 5
        content.backgroundColor = UIColor(named: "gray-elektra")
        return content
    }()
    
    lazy var title: UILabel = {
        let title = LabelBottomBordered(frame: .zero, color: UIColor(named: "lightGray-elektra"))
        title.text = "ORC's Semanal"
        title.textAlignment = .center
        title.textColor = .black
        title.font = .boldSystemFont(ofSize: title.font.pointSize)
        title.minimumScaleFactor = 0.2
        title.adjustsFontSizeToFitWidth = true
//        title.drawText(in: .init(
//            origin: title.frame.origin,
//            size: .init(width: title.frame.width, height: title.frame.height - 5)
//        ))
        return title
    }()
    
    lazy var tableORC: TableORC = TableORC(exp: 31.22,neg: 61.69, total: 92.91, seg: 81.03)
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tableORC])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    var widgetSize: CGFloat {
        willSet {
            widgetHeight = widgetSize
            widgetWidth = widgetSize * 1.5
        }
    }
    
    private var widgetHeight: CGFloat
    private var widgetWidth: CGFloat
    
    init(widgetSize: CGFloat) {
        self.widgetSize = widgetSize
        self.widgetHeight = widgetSize
        self.widgetWidth = widgetSize * 1.5
        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    private func setupView() {
        addSubview(content)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(widgetWidth)
            make.height.equalTo(widgetHeight)
        }
        
        content.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.setupContent()
    }
    
    private func setupContent() {
        content.addSubview(title)
        content.addSubview(hstack)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        hstack.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        tableORC.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
}

internal class TableORC: UIView {
    
    lazy var extraColumn: ColumnORC = {
        let column = ColumnORC(title: " ", value: "P", extra: "R")
        column.resizeEqually = true
        return column
    }()
    lazy var expColumn = ColumnORC(title: "Exp.", value: "\(exp)", extra: "1")
    lazy var negColumn = ColumnORC(title: "Neg.", value: "\(neg)", extra: "4")
    lazy var totalColumn = ColumnORC(title: "Total", value: "\(total)", extra: "1")
    lazy var segColumn = ColumnORC(title: "Seg.", value: "\(seg)")
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            expColumn,
            negColumn,
            totalColumn,
            segColumn
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var parentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            extraColumn,
            hstack
        ])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    var exp: Double
    var neg: Double
    var total: Double
    var seg: Double
    
    init(exp: Double, neg: Double, total: Double, seg: Double) {
        self.exp = exp
        self.neg = neg
        self.total = total
        self.seg = seg
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    private func setupView() {
        addSubview(parentStack)
        parentStack.addArrangedSubview(hstack)
        
        parentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        extraColumn.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        
        expColumn.backgroundColor = UIColor(named: "blue-table")
        negColumn.backgroundColor = UIColor(named: "gray-table")
        segColumn.backgroundColor = UIColor(named: "yellow-table")
    }
}

internal class ColumnORC: UIView {
    
    lazy var titleLabel = element(value: title, isBold: true)
    lazy var valueLabel = element(value: value)
    lazy var extraLabel = element(value: extra)
    
    lazy var vstack: UIStackView = {
        let vstack = UIStackView(arrangedSubviews: [
            titleLabel,
            valueLabel,
            extraLabel
        ])
        vstack.axis = .vertical
        vstack.distribution = .equalSpacing
        vstack.spacing = 2
        return vstack
    }()
    
    private let title: String
    private let value: String
    private let extra: String
    var resizeEqually: Bool = false
    
    init(title: String, value: String, extra: String = "") {
        self.title = title
        self.value = value
        self.extra = extra
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(resizeEqually ? frame.height / 2.5 : frame.height / 3)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.height.equalTo(resizeEqually ? frame.height / 4 : frame.height / 3)
        }
        
        extraLabel.snp.makeConstraints { make in
            make.height.equalTo(resizeEqually ? frame.height / 4 : frame.height / 6)
        }
        
        if resizeEqually {
            valueLabel.textColor = UIColor(named: "lightGray-elektra")
            extraLabel.textColor = UIColor(named: "lightGray-elektra")
        }
    }
    
    private func setupView() {
        addSubview(vstack)
        
        vstack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(6)
        }
    }
    
    private func element(value: String, isBold: Bool = false) -> UILabel  {
        let element = UILabel(frame: .zero)
        element.text = value
        element.textColor = .black
        element.textAlignment = .center
        element.sizeToFit()
        element.minimumScaleFactor = 0.2
        element.adjustsFontSizeToFitWidth = true
        if isBold {
            element.font = .boldSystemFont(ofSize: element.font.pointSize)
        }
        return element
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct ORCWidgetView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        ORCWidgetView(widgetSize: 150).showPreview()
            .ignoresSafeArea()
            .frame(
                minWidth: 300,
                maxWidth: 300,
                minHeight: 150,
                maxHeight: 150,
                alignment: .center
            )
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
#endif

