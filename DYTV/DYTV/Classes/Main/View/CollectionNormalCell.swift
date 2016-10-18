//
//  CollectionNormalCell.swift
//  DYTV
//
//  Created by 谭安溪 on 16/9/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionBasicCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
        
    }
}
