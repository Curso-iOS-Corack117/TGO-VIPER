//
//  HomeView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 19/02/23.
//

import UIKit

class HomeView: UIViewController {
    
    lazy var pdvStackWidget: PDVStackWidgetView = {
        let pdvWidget = PDVStackWidgetView(frame: .zero)
        return pdvWidget
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        view.addSubview(pdvStackWidget)
        
        pdvStackWidget.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        view.backgroundColor = .white
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

