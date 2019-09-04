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
        noticeRequest()
        
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
    
    func noticeRequest(){
        self.indicator.startAnimating()
        NoticeService.shared.getNoticeResult(){ data in
            self.items = data
            self.tableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - section수
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    //MARK: cell수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Review: [Refactoring] 1+1 연산과 같은 코드는 추후에 변경되면서 깨지기 쉬운 코드가 될 수 있습니다.
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
        
        // Review: [Refactoring] row == 0 와 같이 Expandable Cell의 상태를 관리하는 것보단
        // collapse 와 같이 DataModel을 만드는 것은 어떨까요?
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
