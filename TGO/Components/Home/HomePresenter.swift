//
//  HomePresenter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 14/03/23.
//

import Foundation

protocol HomeViewUI: AnyObject {
    func updateView() -> Void
}
protocol HomePresentable: AnyObject {
    var viewUI: HomeViewUI? { get }
}

class HomePresenter: HomePresentable {
    weak var viewUI: HomeViewUI?
}

