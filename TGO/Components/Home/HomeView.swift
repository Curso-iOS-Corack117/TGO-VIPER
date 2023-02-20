//
//  HomeView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class HomeView: UIView {
    
    //    GeometryReader { geo in
    //        HStack {
    //            PDVWidgetView()
    //                .frame(
    //                    //                        originalmente era 0.7
    //                    maxWidth: geo.size.width * 0.45
    //                )
    //            CalendarWidget()
    //        }
    //        .frame(maxWidth: .infinity, alignment: .leading)
    //        .padding()
    //    }
    //    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    lazy var pdvWidgetView: UIView = PDVCard()
//    lazy var calendarWidgetView: UIView = CalendarWidget()
    
    lazy var hstack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        addSubview(hstack)
        let a = AcuerdosCircleView(widgetSize: 150)
        addSubview(a)
        a.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        pdvWidgetView.snp.makeConstraints { make in
//            make.width.equalToSuperview().multipliedBy(0.45)
//        }
        backgroundColor = .blue
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct HomeView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        HomeView().showPreview()
            .background(Color.white)
            .ignoresSafeArea()
    }
}
#endif

