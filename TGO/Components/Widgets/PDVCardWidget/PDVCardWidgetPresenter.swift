//
//  PDVCardWidgetPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 02/03/23.
//

import Foundation

//Protocolo preteneciente a la vista para su conexión con el presentador
protocol PDVCardWidgetUI: AnyObject {
    var presenter: PDVCardWidgetPresenter? { get set }
    var stackWidgetDelegate: PDVStackWidgetPresenter? { get set }
    func updateView() -> Void
}

//Extension del protocolo para variables opcionales
extension PDVCardWidgetUI {
    var stackWidgetDelegate: PDVStackWidgetPresenter? { return nil }
}

//Protocolo perteneciente al presentador
protocol PDVCardWidgetPresentable: AnyObject {
    var viewUI: PDVCardWidgetUI? { get }
    var id: Int? { get }
}

//Presentador
class PDVCardWidgetPresenter: PDVCardWidgetPresentable {
    var viewUI: PDVCardWidgetUI?
    var id: Int?
    
    init(viewUI: PDVCardWidgetUI? = nil, id: Int? = nil) {
        self.viewUI = viewUI
        self.id = id
    }
    
    
}
