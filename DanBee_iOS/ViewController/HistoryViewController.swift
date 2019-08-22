//
//  HistoryViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var items = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        historyRequest()
        uiSet()
    }
}

extension HistoryViewController {
    func uiSet(){
        self.tableView.separatorColor = UIColor.danbeeColor1
    }
    
    func historyRequest() {
        self.indicator.startAnimating()
        HistoryService.shared.getHistoryResult(userid: UserInfo.shared.userid){ data in
            self.items = data
            self.tableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as? HistoryTableViewCell else {fatalError()}
        
        //역순정렬
        cell.kickIdLabel.text = "\(items[self.items.count - indexPath.row - 1].kickid)"
        cell.dateLabel.text = items[self.items.count - indexPath.row - 1].dateFormatter()
        cell.useTimeLabel.text = items[self.items.count - indexPath.row - 1].useTimeFormatter()
        return cell
    }
    
    
}
