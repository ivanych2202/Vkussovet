//
//  FoodCategoryViewCell.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import UIKit

class FoodCategoryViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subMenuCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
        
    static func nib() ->  UINib {
        return UINib(nibName: "FoodCategoryViewCell", bundle: nil)
    }
}
