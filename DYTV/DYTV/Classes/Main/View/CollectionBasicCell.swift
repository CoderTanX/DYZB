//
//  CollectionBasicCell.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class CollectionBasicCell: UICollectionViewCell {
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchor: AnchorModel?{
        didSet{
            guard let anchor = anchor else {return}
            
            roomImageView.kf.setImage(with: URL(string: anchor.vertical_src), placeholder: UIImage(named: "Img_default"))
            nicknameLabel.text = anchor.nickname
            var onlineStr: String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
        }
    }
}
