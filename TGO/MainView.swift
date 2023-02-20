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
    
    private func setupView() {
        view.addSubview(content)
        content.addSubview(sidebar)
        content.addSubview(bodyView)
        
        content.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        sidebar.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        bodyView.snp.makeConstraints { make in
            make.leading.equalTo(sidebar.getSidebarWidth())
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        updateMainView()
    }
    
    private func updateMainView() {
        var viewController = UIView(frame: .zero)
        for v in bodyView.subviews {
            v.removeFromSuperview()
        }
        
        switch sidebar.presenter.viewType {
            case .home:
                viewController = HomeView(frame: .zero)
            case .agenda:
                viewController = HomeView(frame: .zero)
            case .dashboard:
                viewController = HomeView(frame: .zero)
            case .visita_pdv:
                viewController = HomeView(frame: .zero)
            case .chat_zeus:
                viewController = HomeView(frame: .zero)
            case .ayuda:
                viewController = HomeView(frame: .zero)
        }
        bodyView.addSubview(viewController)
        viewController.snp.makeConstraints { make in
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
