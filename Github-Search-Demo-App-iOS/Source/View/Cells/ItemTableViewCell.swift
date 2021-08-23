//
//  ItemTableViewCell.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10
    }

    func configure(cell model: Item) {
        repoNameLabel.text  = model.name
        if let language = model.language, let count = model.starCount {
            let formatCount = Utils.formatNumber(count)
            languageLabel.text  = "\(language)  |  ☆ \(formatCount)"
        }else {
            languageLabel.text  = model.language
        }
        likeLabel.isHidden = true
        if model.userPref == .like {
            likeLabel.isHidden = false
            likeLabel.text = "👍"
        }else if model.userPref == .dislike {
            likeLabel.isHidden = false
            likeLabel.text = "👎"
        }
    }
    
}
