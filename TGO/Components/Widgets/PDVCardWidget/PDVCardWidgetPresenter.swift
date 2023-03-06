//
//  PDVCardWidgetPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 02/03/23.
//

import Foundation

//Protocolo preteneciente a la vista para su conexión con el presentador
protocol PDVCardWidgetViewUI: AnyObject {
    var presenter: PDVCardWidgetPresenter? { get set }
    var stackWidgetDelegate: PDVStackWidgetPresenter? { get set }
    func updateView() -> Void
}

//Extension del protocolo para variables opcionales
extension PDVCardWidgetViewUI {
    var stackWidgetDelegate: PDVStackWidgetPresenter? { return nil }
}

//Protocolo perteneciente al presentador
protocol PDVCardWidgetViewPresentable: AnyObject {
    var viewUI: PDVCardWidgetViewUI? { get }
    var id: Int? { get }
}

//Presentador
class PDVCardWidgetPresenter: PDVCardWidgetViewPresentable {
    var viewUI: PDVCardWidgetViewUI?
    var id: Int?
    
    init(viewUI: PDVCardWidgetViewUI? = nil, id: Int? = nil) {
        self.viewUI = viewUI
        self.id = id
    }
    
    
}
