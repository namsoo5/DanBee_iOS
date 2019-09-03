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

    @IBOutlet weak var indicator: UIActivityIndicatorView!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangePw" {
            // swiftlitn:disable force_cast
            let nextVC: ChangePwViewController = segue.destination as! ChangePwViewController
            nextVC.userid = self.idTextField.text!
        }
    }
    
    @IBAction func searchButtonClick(_ sender: Any) {
        guard let name = self.nameTextField.text else {return}
        guard let phone = self.phoneTextField.text else {return}
        
        self.indicator.startAnimating()
        
        if self.viewModel.segmentObservable.value == 0 {
            SearchUserService.shared.getSearchIdResult(name: name, phone: phone){
                id in
                self.indicator.stopAnimating()
                if id == "" {
                    self.simpleAlert(title: "아이디", msg: id)
                }else {
                    self.simpleAlert(title: "실패", msg: "다시 한 번 확인해주세요.")
                }
            }
        }else {
            guard let id = self.idTextField.text else {return}
            guard let birth = self.birthTextField.text else {return}
            SearchUserService.shared.getSearchPwResult(userid: id, name: name, phone: phone, birth: birth){
                b in
                self.indicator.stopAnimating()
                if b {
                    self.performSegue(withIdentifier: "ChangePw", sender: self)
                }else {
                    self.simpleAlert(title: "실패", msg: "다시 한 번 확인해주세요.")
                }
            }
        }
        
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
