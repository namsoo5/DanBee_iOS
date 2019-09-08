//
//  NoticeWriteViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 06/09/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class NoticeWriteViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        
        
    }
    
    func uiSet(){
        let textView: [UITextView] = [titleTextView, contentTextView]
        for view in textView {
            view.layer.cornerRadius = 5
            view.layer.borderColor = UIColor.danbeeColor2.cgColor
            view.layer.borderWidth = 2
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(wirteClick))
        
    }
    
    @objc func wirteClick() {
        
    }
    
    

}
