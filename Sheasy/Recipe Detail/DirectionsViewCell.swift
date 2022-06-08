//
//  DirectionsViewCell.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 07.06.2022.
//

import Foundation
import UIKit

class DirectionsViewCell: UITableViewCell {

    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var sourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(for result: SearchRecipesResults) {
        directionsButton.layer.cornerRadius = 5
        sourceLabel.text = result.recipe.source
    }
//    func configure(for result: TrendingResults) {
//        directionsButton.layer.cornerRadius = 5
//        sourceLabel.text = result.recipe.source
//    }
    func configure(for result: RecommendationResults) {
        directionsButton.layer.cornerRadius = 5
        sourceLabel.text = result.recipe.source
    }
}
