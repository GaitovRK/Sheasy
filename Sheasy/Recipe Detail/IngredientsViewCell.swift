//
//  IngredientsViewCell.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 07.06.2022.
//

import Foundation
import UIKit

class IngredientsViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
