//
//  SidebarView.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import UIKit

class SidebarView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.layer.opacity = 0.2
        return view
    }()
    
    lazy var sidebarContent: SidebarContentView = {
        let sidebarContent = SidebarContentView(frame: .zero)
        return sidebarContent
    }()
    
    var presenter: SidebarViewPresentable
    
    init(presenter: SidebarViewPresentable) {
        self.presenter = presenter
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error al inicializar la vista")
    }
    
    private func setupView() {
        addSubview(sidebarContent)
        
        sidebarContent.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(getSidebarWidth())
        }
    }
    
    func getSidebarWidth() -> CGFloat {
        let devicePosition = UIDevice.current.orientation.isLandscape
        let widthScreen = UIScreen.main.bounds.size.width
        let percentage = devicePosition ? 0.06 : 0.07
        let sidebarWidth = widthScreen * percentage
        return sidebarWidth
    }
}

extension SidebarView: SidebarViewUI {
    func updateSidebarContraints() {
        let sidebarWidth = getSidebarWidth()
        
        sidebarContent.snp.updateConstraints { make in
            make.width.equalTo(sidebarWidth)
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 14, *)
struct SidebarView_Preview: PreviewProvider {
    
    static var previews: some View {
        var sidebarView: SidebarView = {
            let presenter = SidebarViewPresenter()
            let sidebar = SidebarView(presenter: presenter)
            presenter.viewUI = sidebar
            return sidebar
        }()
        // view controller using programmatic UI
        sidebarView.showPreview()
            .background(Color.white)
            .ignoresSafeArea()
    }
}
#endif
