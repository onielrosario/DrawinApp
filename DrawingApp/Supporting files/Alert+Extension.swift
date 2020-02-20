//
//  Alert+Extension.swift
//  DrawingApp
//
//  Created by Oniel Rosario on 2/19/20.
//  Copyright © 2020 Oniel Rosario. All rights reserved.
//

import UIKit

extension UIViewController {
  
  public func showAlert(title: String?, message: String?, actionTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: actionTitle, style: .default) { alert in }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  public func showAlert(title: String?, message: String?,
                        style: UIAlertController.Style,
                        handler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
     let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(cancelAction)
    let customAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
    alertController.addAction(customAction)
    present(alertController, animated: true)
  }
  
  public func showDestructionAlert(title: String?, message: String?,
                                   style: UIAlertController.Style,
                                   handler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    let okAction = UIAlertAction(title: "Cancel", style: .cancel)
    let customAction = UIAlertAction(title: "Confirm", style: .destructive, handler: handler)
    alertController.addAction(okAction)
    alertController.addAction(customAction)
    present(alertController, animated: true)
  }
    
    public func showActionSheet(title: String?, message: String?, actionTitles: [String], handlers: [((UIAlertAction) -> Void)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, actionTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: actionTitle, style: .default, handler: handlers[index])
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
