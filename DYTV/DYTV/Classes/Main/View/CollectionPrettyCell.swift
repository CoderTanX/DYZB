//
//  CollectionPrettyCell.swift
//  DYTV
//
//  Created by 谭安溪 on 16/9/20.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBasicCell {

    @IBOutlet weak var cityBtn: UIButton!
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
