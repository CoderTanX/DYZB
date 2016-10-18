//
//  CollectionCycleCell.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var picImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel?{
        didSet{
            guard let cycleModel = cycleModel else { return }
            picImageVIew.kf.setImage(with: URL(string: cycleModel.pic_url), placeholder:UIImage(named: "Img_default"))
            titleLabel.text = cycleModel.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
