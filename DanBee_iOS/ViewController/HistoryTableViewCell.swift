//
//  HistoryTableViewCell.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var kickIdLabel: UILabel!
    @IBOutlet weak var useTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateLabel.sizeToFit()
        self.kickIdLabel.sizeToFit()
        self.useTimeLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
