//
//  ProfileViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 20/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import MaterialCard

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()

    }
    
    @IBAction func removeUserButtonClick(_ sender: Any) {
        
    }
  
    @IBAction func changePwButtonClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePw") else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProfileViewController {
    func uiSet(){
        self.userImg.layer.borderColor = UIColor.black.cgColor
        self.userImg.layer.cornerRadius = 45
        self.userImg.layer.borderWidth = 2
        
    }
    
}

extension MaterialCard {
    public override func awakeFromNib() {
        self.cornerRadius = 8
        self.shadowOffsetHeight = 2
        self.shadowOffsetWidth = 1
        self.shadowOpacity = 0.5
    }
}
