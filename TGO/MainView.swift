//
//  ViewController.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    lazy var sidebar: SidebarView = {
        let presenter = SidebarViewPresenter()
        let sidebar = SidebarView(presenter: presenter)
        presenter.viewUI = sidebar
        return sidebar
    }()
    
    lazy var bodyView: UIView = {
        let content = UIView(frame: .zero)
        return content
    }()
    
    lazy var content: UIView = {
        return UIView(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        sidebar.presenter.sidebarWidth = SidebarView.getSidebarWidth()
        updateView()
    }
    
    private func setupView() {
        view.addSubview(content)
        content.addSubview(bodyView)
        content.addSubview(sidebar)
        
        content.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        sidebar.snp.makeConstraints { make in
            make.width.equalTo(SidebarView.getSidebarWidth())
            make.height.equalToSuperview()
        }
        
        bodyView.snp.makeConstraints { make in
            make.leading.equalTo(SidebarView.getSidebarWidth())
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        updateMainView()
    }
    
    private func updateView() {
        bodyView.snp.updateConstraints { make in
            make.leading.equalTo(sidebar.presenter.sidebarWidth)
        }
    }
    
    private func updateMainView() {
        var vc = UIViewController()
        self.children.forEach({
            $0.view.removeFromSuperview();
            $0.removeFromParent()
        })
        
        switch sidebar.presenter.viewType {
            case .home:
            vc = HomeView()
            case .agenda:
            vc = HomeView()
            case .dashboard:
            vc = HomeView()
            case .visita_pdv:
            vc = HomeView()
            case .chat_zeus:
            vc = HomeView()
            case .ayuda:
            vc = HomeView()
        }
        addChild(vc)
        bodyView.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        vc.didMove(toParent: self)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct MainView_Preview: PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        MainView().showPreview()
            .background(Color.white)
            .ignoresSafeArea()
    }
}
#endif
