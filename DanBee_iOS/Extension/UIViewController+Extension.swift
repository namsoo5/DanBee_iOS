//
//  UIViewController+Extension.swift
//  DanBee_iOS
//
//  Created by 남수김 on 17/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func toRootAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .cancel, handler: { action in self.navigationController?.popToRootViewController(animated: true)
            
        })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func choiceAlert(title: String, msg: String, okHandler: ((UIAlertAction)->Void)? ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .destructive, handler: okHandler )
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func popAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: {
            action in
            self.navigationController?.popViewController(animated: true)
        } )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
