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
        content.layer.shadowColor = UIColor.black.cgColor
        content.layer.shadowOpacity = 0.5
        content.layer.masksToBounds = false
        content.layer.shadowOffset = CGSize(width: -1, height: -1)
        content.layer.cornerRadius = 5
        content.backgroundColor = UIColor(named: "background-widget")
        return content
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.text = "ORC's"
        title.textAlignment = .center
        title.textColor = .black
        title.font = .boldSystemFont(ofSize: title.font.pointSize)
        title.minimumScaleFactor = 0.2
        title.adjustsFontSizeToFitWidth = true
        return title
    }()
    
    lazy var subtitle: UILabel = {
        let subtitle = UILabel(frame: .zero)
        subtitle.text = "Puntos Ranking"
        subtitle.textColor = .black
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 2
        subtitle.font = .boldSystemFont(ofSize: subtitle.font.pointSize)
        subtitle.minimumScaleFactor = 0.1
        subtitle.adjustsFontSizeToFitWidth = true
        return subtitle
    }()
    
    lazy var tableORC: TableORC = TableORC(exp: 31.22,neg: 61.69, total: 92.91, seg: 81.03)
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subtitle, tableORC])
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
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(widgetHeight / 8)
        }
        
        hstack.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        subtitle.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0 / 6.0)
            make.height.equalToSuperview()
        }
        
        tableORC.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(subtitle.snp.trailing).offset(8)
        }
    }
}

internal class TableORC: UIView {
    
    lazy var expColumn: ColumnORC = {
        return ColumnORC(title: "Exp.", value: "\(exp)", extra: "1")
    }()
    
    lazy var negColumn: ColumnORC = {
        return ColumnORC(title: "Neg.", value: "\(neg)", extra: "4")
    }()
    
    lazy var totalColumn: ColumnORC = {
        return ColumnORC(title: "Total", value: "\(total)", extra: "1")
    }()
    
    lazy var segColumn: ColumnORC = {
        return ColumnORC(title: "Seg.", value: "\(seg)")
    }()
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            expColumn,
            negColumn,
            totalColumn,
            segColumn
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
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
        addSubview(hstack)
        
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            make.height.equalTo(frame.height / 3)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.height.equalTo(frame.height / 3)
        }
        
        extraLabel.snp.makeConstraints { make in
            make.height.equalTo(frame.height / 6)
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
        element.textAlignment = .center
        element.sizeToFit()
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
        ORCWidgetView(widgetSize: 100).showPreview()
            .ignoresSafeArea()
            .frame(
                minWidth: 150,
                maxWidth: 150,
                minHeight: 100,
                maxHeight: 100,
                alignment: .center
            )
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
#endif

