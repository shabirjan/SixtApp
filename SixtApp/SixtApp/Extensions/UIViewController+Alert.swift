//
//  UIViewController+Alert.swift
//  DaleniApp
//
//  Created by Shabir Jan on 26/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    
    public func showAlertWithMessage(_ message:String?)
    {
        showAlert("Alert", message: message, cancelButtonTitle: "Ok")
    }
    public func showAlert(_ title:String, message:String?, cancelButtonTitle:String){
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
       showAlert(title, message: message, alertActions: [cancelButton])
    }
    
    public func showAlert(_ title: String?, message: String?, alertActions: [UIAlertAction]) {
        showAlert(title, message: message, preferredStyle: .alert, alertActions: alertActions)
    }
    
    public func showActionSheet(_ title:String?, message:String?, alertActions : [UIAlertAction]){
        showAlert(title, message: message, preferredStyle: .actionSheet, alertActions: alertActions)
    }
    public func showAlert(_ title:String?, message:String?, preferredStyle: UIAlertControllerStyle,alertActions:[UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for alertAction in alertActions{
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
