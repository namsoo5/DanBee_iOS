//
//  NoticeViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 24/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var items = [Notice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        uiSet()
        writeNoticeButtonSet()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.indicator.startAnimating()
        if self.segmentControl.selectedSegmentIndex == 0{
            NoticeService.shared.getNoticeResult(){ data in
                self.items = data
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }else{
            NoticeService.shared.getQuestionResult(){ data in
                self.items = data
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
    
    @IBAction func segmentClick(_ sender: UISegmentedControl) {
        self.indicator.startAnimating()
        if sender.selectedSegmentIndex == 0{
            NoticeService.shared.getNoticeResult(){ data in
                self.items = data
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }else{
            NoticeService.shared.getQuestionResult(){ data in
                self.items = data
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
}

extension NoticeViewController {
    func uiSet() {
        self.segmentControl.tintColor = UIColor.danbeeColor1
        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.segmentControl.setTitleTextAttributes(textAttribute, for: .normal)
        
        self.tableView.separatorColor = UIColor.clear
    }
    
    func writeNoticeButtonSet(){
        if UserInfo.shared.isAdmin {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(writeNoticeButtonClick))
        }
    }
    
    @objc func writeNoticeButtonClick(){
        guard let nextVC: NoticeWriteViewController = self.storyboard?.instantiateViewController(withIdentifier: "noticeWirte") as? NoticeWriteViewController else {return}
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - section수
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    //MARK: cell수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items[section].open == true {
            return 1 + 1
        }else{
            return 1
        }
    }
    
    //MARK: cell구현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: NoticeTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "noticeTitle", for: indexPath) as! NoticeTitleTableViewCell
            
            cell.titleLabel.text = items[indexPath.section].title
            
            return cell
        }else {
            //클릭시 펼쳐질 셀
            let cell: NoticeContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "noticeContent", for: indexPath) as! NoticeContentTableViewCell
            
            cell.dateLabel.text = items[indexPath.section].dateFormat()
            cell.titleLabel.text = items[indexPath.section].title
            cell.contentTextView.text = items[indexPath.section].content
            
            return cell
        }
    }
    
    //MARK: cell확장효과
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NoticeTitleTableViewCell else {return}
        guard let index = tableView.indexPath(for: cell) else { return }
        
        if index.row == indexPath.row {
            if index.row == 0 {
                if items[indexPath.section].open == true {
                    items[indexPath.section].open = false
                    cell.arrowImg.image = UIImage(named: "uparrow")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                    
                }else {
                    items[indexPath.section].open = true
                    cell.arrowImg.image = UIImage(named: "downarrow")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                }
            }
        }
        
    }
    
    //MARK: cell크기
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }else {
            return 250
        }
    }
}
