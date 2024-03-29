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
    
    lazy var container = UIView(frame: .zero)
    
    var presenter: HomePresenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewUI = self
        self.setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async { [self] in
            print("hola")
            pdvStackWidget.updateWidget()
        }
    }
    
    private func setupView() {
        view.addSubview(container)
        container.addSubview(pdvStackWidget)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        pdvStackWidget.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        view.backgroundColor = .white
    }
}

extension HomeView: HomeViewUI {
    func updateView() {
        
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

