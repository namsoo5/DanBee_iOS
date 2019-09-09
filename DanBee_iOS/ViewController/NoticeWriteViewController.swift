//
//  NoticeWriteViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 06/09/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class NoticeWriteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet var segmentTopLayout: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        uiSet()
        
    
        //observer등록
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //observer해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func textViewMoveUp(_ notification: NSNotification){
        
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //-keyboardSize.height
            UIView.animate(withDuration: 0.3, animations: {
                self.segmentTopLayout.transform = CGAffineTransform(translationX: 0, y: -190)
            })
            
//        }
    }
    
    @objc func textViewMoveDown(_ notification: NSNotification){
            self.segmentTopLayout.transform = .identity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

extension NoticeWriteViewController {
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
        self.indicator.startAnimating()
        NoticeService.shared.getWriteResult(type: type, title: title, content: content){
            result in
            if result {
                self.popAlert(title: "작성완료", msg: "성공적으로 작성하였습니다.")
            }else{
                self.popAlert(title: "작성실표", msg: "쳐리중 알 수 없는 오류가 발생했습니다.")
            }
            self.indicator.stopAnimating()
        }
    }
    
}
