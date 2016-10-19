//
//  CollectionViewGameCell.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var game: BaseGameModel?{
        didSet{
            guard let game = game else { return }
            iconImageView.kf.setImage(with: URL(string: game.icon_url), placeholder: UIImage(named: "home_more_btn"))
            titleLabel.text = game.tag_name

        }
    }

}
