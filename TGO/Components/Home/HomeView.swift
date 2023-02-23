//
//  HomeView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class HomeView: UIView {
    
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
        let a = PDVCardWidgetView(frame: .zero)
        addSubview(a)
        a.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundColor = .white
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

