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
        content.layer.backgroundColor = UIColor.red.cgColor
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
    
    lazy var expColumn: UIView = {
        return UIView(frame: .zero)
    }()
    
    lazy var negColumn: UIView = {
        return UIView(frame: .zero)
    }()
    
    lazy var totalColumn: UIView = {
        return UIView(frame: .zero)
    }()
    
    lazy var segColumn: UIView = {
        return UIView(frame: .zero)
    }()
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            expColumn,
            negColumn,
            totalColumn,
            segColumn
        ])
        stack.axis = .horizontal
        stack.backgroundColor = .red
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
        
        backgroundColor = .blue
        
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

internal class ColumnORC: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
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

