//
//  ViewController.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 14.05.2022.
//

import UIKit

// MARK: TableView
// MARK: Custom Cell
// MARK: API Caller
// MARK: Open Recipe details screen


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getRecipes { result in
            
        }
    }

}





// MARK: TrashBox
//    let url = URL(string: "https://developer.edamam.com/edamam-docs-recipe-api")

//    URLSession.shared.dataTask(with: url!) { (data, response, error) in
//        if error == nil {
//            do {
//                self.recipes =  try JSONDecoder().decode([Recipe].self, from: data!)
//            } catch {
//                print("Parse error")
//            }
//
//            DispatchQueue.main.async {
//                print(self.recipes.count)
//            }
//        }
//    }.resume()
//
//    view.addSubview(collectionViewUpdated)
//
//    collectionView.delegate = self
//    collectionView.dataSource = self


//extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        performSegue(withIdentifier: "goToThird", sender: self)
//        print("TAP Made")
//    }
//@IBOutlet var collectionView: UICollectionView!

//private let collectionViewUpdated = UICollectionView(
//    frame: .zero,
//    collectionViewLayout: UICollectionViewFlowLayout()
//)
//
//let urlString = "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg/preview"
//let API_Key = "ede0ea6a7ba1bd268513c60665786642"
//let APP_ID = "e92ce914"
//
//var recipes = [Recipe]()
//
//

//}
//
//extension ViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1111
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
//
//        cell.configure(with: UIImage(named: "Image1"))
//
//        return cell
//    }
//}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 250)
//    }
//}
//
