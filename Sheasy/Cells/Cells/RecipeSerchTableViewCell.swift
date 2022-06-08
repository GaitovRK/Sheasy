//
//  RecipeSerchTableViewCell.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 07.06.2022.
//

import UIKit

class SearchRecipesResultCell: UITableViewCell {

    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeDescriptionLabel: UILabel!
    @IBOutlet var recipeImageView: UIImageView!
    var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
    }
    // MARK: - Helper Methods
    func configure(for result: SearchRecipesResults) {
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        else {
            recipeDescriptionLabel.text = String(format: "%@ (%@)", result.recipe.source!, (result.recipe.cuisineType.first!!).capitalizingFirstLetter())
        }
        recipeImageView.image = UIImage(systemName: "square")
        recipeImageView.layer.borderWidth = 2
        recipeImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        recipeImageView.layer.cornerRadius = 5.0
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImageView.loadImage(url: previewURL)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension UIImageView {
  func loadImage(url: URL) -> URLSessionDownloadTask {
    let session = URLSession.shared
    let downloadTask = session.downloadTask(with: url) {
      [weak self] url, _, error in

      if error == nil, let url = url,
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {

        DispatchQueue.main.async {
          if let weakSelf = self {
            weakSelf.image = image
          }
        }
      }
    }
    downloadTask.resume()
    return downloadTask
  }
}
