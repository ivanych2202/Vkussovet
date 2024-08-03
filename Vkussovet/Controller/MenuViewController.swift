//
//  MenuViewController.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var foodCategory: UICollectionView!
    @IBOutlet weak var foodName: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categories: [FoodCategory] = []
    var foodNames: [FoodName] = []
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCategory.register(FoodCategoryViewCell.nib(), forCellWithReuseIdentifier: "FoodCategoryViewCell")
        foodName.register(FoodNameViewCell.nib(), forCellWithReuseIdentifier: "FoodNameViewCell")
        
        foodCategory.delegate = self
        foodName.delegate = self
        foodCategory.dataSource = self
        foodName.dataSource = self
        
        ApiManager.shared.getCategory { [weak self] categories in
            guard let self = self else { return }
            if let categories = categories {
                self.categories = categories
                self.foodCategory.reloadData()
 
            }
        }

    }
}
        


extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = categories[indexPath.item]
        categoryLabel.text = category.name
        
        

        if let previousIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: previousIndexPath) as? FoodCategoryViewCell
            previousCell?.contentView.backgroundColor = UIColor.darkGray
        }

        let selectedCell = collectionView.cellForItem(at: indexPath) as? FoodCategoryViewCell
        selectedCell?.contentView.backgroundColor = UIColor.systemIndigo

        selectedIndexPath = indexPath
        
        if collectionView == foodCategory {
            ApiManager.shared.getName(menuID: category.menuID!) { [weak self] names in
                guard let self = self else { return }
                if let names = names {
                    self.foodNames = names
                    self.foodName.reloadData()
                } else {
                    print("Error fetching food names")
                }
            }
        }

    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == foodCategory {
            return categories.count
        } else {
            return foodNames.count
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == foodCategory {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryViewCell", for: indexPath) as! FoodCategoryViewCell
            
            let category = categories[indexPath.item]
            cell.name.text = category.name
            
            if let subMenuCount = category.subMenuCount {
                cell.subMenuCount.text = "\(subMenuCount) товаров"
            } else {
                cell.subMenuCount.text = "0 товаров"
            }
            
            if indexPath == selectedIndexPath {
                cell.contentView.backgroundColor = UIColor.systemIndigo
            } else {
                cell.contentView.backgroundColor = UIColor.darkGray
            }
            
            if let imageURLString = category.image, let imageURL = URL(string: "https://vkus-sovet.ru" + imageURLString) {
                cell.image.image = UIImage(named: "placeholder")
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if collectionView.indexPath(for: cell) == indexPath {
                                cell.image.image = image
                            }
                        }
                    }
                }
            } else {
                cell.image.image = UIImage(named: "placeholder")
            }
            
            return cell
            
        } else if collectionView == foodName {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodNameViewCell", for: indexPath) as! FoodNameViewCell
            let foodName = foodNames[indexPath.item]
            
            cell.name.text = foodName.name
            cell.content.text = foodName.content
            
            if let price = foodName.price {
                let roundedPrice =  Double(price)!.rounded()
                let stringPrice = String(format: "%.0f ₽", roundedPrice)
                cell.price.text = stringPrice
            }

            if let weight = foodName.weight {
                cell.weight.text = weight
            }
                
            
            if foodName.spicy == "Y"{
                cell.spicy.image = UIImage(resource: ImageResource(name: "pepper" , bundle: .main))
            }
            
            if let imageURLString = foodName.image, let imageURL = URL(string: "https://vkus-sovet.ru" + imageURLString) {
                cell.image.image = UIImage(named: "placeholder")
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if collectionView.indexPath(for: cell) == indexPath {
                                cell.image.image = image
                            }
                        }
                    }
                }
            } else {
                cell.image.image = UIImage(named: "placeholder")
            }
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
}



