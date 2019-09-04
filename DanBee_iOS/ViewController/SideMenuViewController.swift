//
//  SideMenuViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 15/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let menuList = ["QR코드","내정보","이용내역","공지사항/Q&A","사용방법"]
    let menuImg = ["qrcode","profile","history","notice","guide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        uiSet()
    }
    
   
    
    @IBAction func loginButtonClick(_ sender: Any) {
        
        if UserInfo.shared.userid.isEmpty {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") else {return}
            self.present(nextVC, animated: true)
        }else {
            UserInfo.shared.logout()
            self.dismiss(animated: true)
        }
    }

}

extension SideMenuViewController {
    
    func uiSet(){
        self.tableView.separatorColor = UIColor.clear
        self.tableView.isScrollEnabled = false
        //login상태에따른 버튼유무
        if UserInfo.shared.userid.isEmpty {
            self.loginButton.setTitle("로그인", for: .normal)
            self.loginImg.image = UIImage(named: "unlock")
        }else {
            self.loginButton.setTitle("로그아웃", for: .normal)
            self.loginImg.image = UIImage(named: "lock")
        }
    }
    
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlitn:disable force_cast
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! SideMenuTableViewCell
        
        cell.menuLabel.text = menuList[indexPath.row]
        cell.icon.image = UIImage(named: menuImg[indexPath.row])
        return cell
    }
    
    //menu select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case let index where index == 0 && UserInfo.shared.userid.isNotEmpty:
            let nextVC:QRCodeViewController = self.storyboard?.instantiateViewController(withIdentifier: "QRCode") as! QRCodeViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case let index where index == 1 && UserInfo.shared.userid.isNotEmpty:
            let nextVC:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case let index where index == 2 && UserInfo.shared.userid.isNotEmpty:
            let nextVC:HistoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "History") as! HistoryViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 3:
            let nextVC:NoticeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Notice") as! NoticeViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 4:
            let nextVC:GuideViewController = self.storyboard?.instantiateViewController(withIdentifier: "Guide") as! GuideViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        default:
            self.simpleAlert(title: "알림", msg: "로그인이 필요한 기능입니다.")
        }
    }
    
    
}
