//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by 谭安溪 on 16/9/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var group: AnchorGroup?{
        didSet{
            guard let group = group else { return }
            iconImageView.image = UIImage(named: group.icon_name)
            titleLabel.text = group.tag_name
        }
    }
}
