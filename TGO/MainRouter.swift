//
//  MainRouter.swift
//  TGO
//
//  Created by Sergio Ordaz Romero on 18/02/23.
//

import Foundation
import UIKit

class MainRouter {
    func showMain(window: UIWindow?) {
        let view = MainView()
        
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
}
