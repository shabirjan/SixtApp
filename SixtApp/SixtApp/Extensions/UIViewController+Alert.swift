//
//  UIViewController+Alert.swift
//  SixtApp
//
//  Created by Shabir Jan on 26/02/2017.
//  Copyright © 2017 Shabir Jan. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    //MARK: -Method to show Alert with Message
    public func showAlertWithMessage(_ message:String?)
    {
        showAlert("Alert", message: message, cancelButtonTitle: "Ok")
    }
    
    //MARK: -Method to show alert with message ande cancel button title
    public func showAlert(_ title:String, message:String?, cancelButtonTitle:String){
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
       showAlert(title, message: message, alertActions: [cancelButton])
    }
    
    //MARK: -Method to show Alert with title, messsage and alert action
    public func showAlert(_ title: String?, message: String?, alertActions: [UIAlertAction]) {
        showAlert(title, message: message, preferredStyle: .alert, alertActions: alertActions)
    }
    
    //MARK: -Method to show ActionSheet with title, message and alert actions
    public func showActionSheet(_ title:String?, message:String?, alertActions : [UIAlertAction]){
        showAlert(title, message: message, preferredStyle: .actionSheet, alertActions: alertActions)
    }
    
    //MARK: -Method to show alert with title, message , alert style and alert actions.
    public func showAlert(_ title:String?, message:String?, preferredStyle: UIAlertControllerStyle,alertActions:[UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for alertAction in alertActions{
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
