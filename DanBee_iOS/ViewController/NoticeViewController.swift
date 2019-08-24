//
//  NoticeViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 24/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var sementControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Notice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    

}

extension NoticeViewController {
    func uiSet() {
//        self.segmentButton.tintColor = UIColor.danbeeColor1
//        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        self.segmentButton.setTitleTextAttributes(textAttribute, for: .normal)
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
