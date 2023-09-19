//
//  AlertController.swift
//  InfoFilm
//
//  Created by Dima on 14.09.2023.
//

import Foundation
import UIKit
class AlertManager{
    let dataManager = DataManager.shared
    
    func showAddingAlert(_ viewController: UIViewController, content : Result?){
        let addingAlert = UIAlertController(title: "Favorite", message: "Add to favorite?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add", style: .default) { action in
            guard let content = content else { return }
            self.dataManager.saveToRealm(content)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        addingAlert.addAction(saveAction)
        addingAlert.addAction(cancelAction)
        viewController.present(addingAlert, animated: true)
    }
}
