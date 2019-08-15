//
//  SideMenuTableViewCell.swift
//  DanBee_iOS
//
//  Created by 남수김 on 15/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
