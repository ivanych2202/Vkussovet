//
//  FoodNameViewCell.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import UIKit

class FoodNameViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var spicy: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.clipsToBounds = true
    }

    static func nib() -> UINib {
        return UINib(nibName: "FoodNameViewCell", bundle: nil)
    }
}
    
