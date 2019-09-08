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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        
        
    }
    
    
    
    
}

extension NoticeWriteViewController{
    func uiSet(){
        let textView: [UITextView] = [titleTextView, contentTextView]
        for view in textView {
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor.danbeeColor2.cgColor
            view.layer.borderWidth = 3
            
        }
        
        self.segmentControl.tintColor = UIColor.danbeeColor1
        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmentControl.setTitleTextAttributes(textAttribute, for: .normal)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(wirteClick))
        
    }
    
    @objc func wirteClick() {
        guard let title = self.titleTextView.text else{return}
        guard let content = self.contentTextView.text else {return}
        let type = self.segmentControl.selectedSegmentIndex
        
        NoticeService.shared.getWriteResult(type: type, title: title, content: content){
            result in
            if result {
                self.popAlert(title: "작성완료", msg: "성공적으로 작성하였습니다.")
            }else{
                self.popAlert(title: "작성실표", msg: "쳐리중 알 수 없는 오류가 발생했습니다.")
            }
            
        }
    }
    
    
}
