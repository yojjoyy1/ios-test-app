//
//  TbvCell.swift
//  test
//
//  Created by sinyilin on 2018/9/27.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit

class TbvCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
