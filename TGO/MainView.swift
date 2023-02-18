//
//  ViewController.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    lazy var content: UIView = {
        return UIView(frame: .zero)
    }()
    
    lazy var sidebar: SidebarView = {
        let presenter = SidebarViewPresenter()
        let sidebar = SidebarView(presenter: presenter)
        presenter.viewUI = sidebar
        return sidebar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setupView()
    }
    
    private func setupView() {
        view.addSubview(content)
        content.addSubview(sidebar)
        
        content.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        sidebar.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
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
