//
//  PDVStackWidgetPresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 02/03/23.
//

import Foundation

//Protocolo preteneciente a la vista para su conexión con el presentador
protocol PDVStackWidgetViewUI: AnyObject {
    func updatePDV() -> Void
}
//Protocolo perteneciente al presentador
protocol PDVStackWidgetViewPresentable: AnyObject {
    var viewUI: PDVCardWidgetViewUI? { get }
    var id: Int? { get }
}

class PDVStackWidgetPresenter: PDVStackWidgetViewPresentable {
    var viewUI: PDVCardWidgetViewUI?
    var id: Int?
    
    init(viewUI: PDVCardWidgetViewUI? = nil, id: Int? = nil) {
        self.viewUI = viewUI
        self.id = id
    }
    
//    func onViewAppear
}
