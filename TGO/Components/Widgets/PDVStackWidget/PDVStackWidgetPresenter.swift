//
//  PDVStackWidgetPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 02/03/23.
//

import Foundation

//Protocolo preteneciente a la vista para su conexión con el presentador
protocol PDVStackWidgetUI: AnyObject {
    func updateWidget() -> Void
}
//Protocolo perteneciente al presentador
protocol PDVStackWidgetPresentable: AnyObject {
    var viewUI: PDVCardWidgetUI? { get }
    var id: Int? { get }
}

class PDVStackWidgetPresenter: PDVStackWidgetPresentable {
    var viewUI: PDVCardWidgetUI?
    var id: Int?
    
    init(viewUI: PDVCardWidgetUI? = nil, id: Int? = nil) {
        self.viewUI = viewUI
        self.id = id
    }
    
//    func onViewAppear
}
