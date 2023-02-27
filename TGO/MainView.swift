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
            make.height.width.equalToSuperview()
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
        var uiView = UIView(frame: .zero)
        for view in bodyView.subviews {
            view.removeFromSuperview()
        }
        
        switch sidebar.presenter.viewType {
            case .home:
            uiView = HomeView(frame: .zero)
            case .agenda:
            uiView = HomeView(frame: .zero)
            case .dashboard:
            uiView = HomeView(frame: .zero)
            case .visita_pdv:
            uiView = HomeView(frame: .zero)
            case .chat_zeus:
            uiView = HomeView(frame: .zero)
            case .ayuda:
            uiView = HomeView(frame: .zero)
        }
        bodyView.addSubview(uiView)
        uiView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
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
