//
//  SearchUserViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 18/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchUserViewController: UIViewController {

    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    let viewModel: SearchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
        uiSet()
    }
    @IBAction func searchButtonClick(_ sender: Any) {
    }
}

extension SearchUserViewController{
    
    func uiSet() {
        self.segmentButton.tintColor = UIColor.danbeeColor1
        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.segmentButton.setTitleTextAttributes(textAttribute, for: .normal)
    }
    
    func bindInput(){
        segmentButton.rx.selectedSegmentIndex
        .bind(to: self.viewModel.segmentObservable)
        .disposed(by: disposeBag)
    }
    
    func bindOutput(){
        self.viewModel.segmentObservable
            .subscribe(onNext: { index in
                if index == 0 {
                    self.idTextField.isHidden = true
                    self.birthTextField.isHidden = true
                }else {
                    self.idTextField.isHidden = false
                    self.birthTextField.isHidden = false
                }
            })
        .disposed(by: disposeBag)
    }
}
