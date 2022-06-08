//
//  RecipeSearchViewController.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 04.06.2022.
//

import UIKit

class SearchRecipesViewController: UIViewController, RestrictionsControllerDelegate, UINavigationControllerDelegate
    {
    func restrictionsController(_ controller: RestrictionsTableViewController, didFinishAdding item: [ChecklistItem]) {
        restrictions = item
        self.dismiss(animated: false, completion: nil)
    }
    func restrictionsControllerDidCancel(_ controller: RestrictionsTableViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
  
    var searchResults = [SearchRecipesResults]() //  array for data
    var recommendedResults = [RecommendationResults]()
    var searchResultText = ""
    var hasSearched = false
    var restrictions = [ChecklistItem]()
    var dataTask: URLSessionDataTask?
    
    
    struct TableView {
      struct CellIdentifiers {
        static let searchRecipesResultCell = "SearchRecipesResultCell"
        static let noRecipesFoundCell = "NoRecipesFoundCell"
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerDefaults()

        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.becomeFirstResponder() // dismiss keyboard
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchRecipesResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchRecipesResultCell)
       
        cellNib = UINib(nibName: TableView.CellIdentifiers.noRecipesFoundCell, bundle: nil)
        tableView.register(
          cellNib,
          forCellReuseIdentifier: TableView.CellIdentifiers.noRecipesFoundCell)

        if !hasSearched {
            recommendedResults = RecommendationRecipes.recommendationRecipies()
        }
    }
    
    
    // MARK: - Navigation Controller Delegates
    func registerDefaults() {
      let dictionary = [ "RecipesIndex": -1 ]
      UserDefaults.standard.register(defaults: dictionary)
        
        let dictionary2 = [ "RecipesSection": -1 ]
        UserDefaults.standard.register(defaults: dictionary2)
    }

    func navigationController(
      _ navigationController: UINavigationController,
      willShow viewController: UIViewController,
      animated: Bool
    ) {
      // Was the back button tapped?
      if viewController === self {
        UserDefaults.standard.set(-1, forKey: "RecipesIndex")
        UserDefaults.standard.set(-1, forKey: "RecipesSection")
      }
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      navigationController?.delegate = self

        let index = UserDefaults.standard.integer(
            forKey: "RecipesIndex")
        let sections = UserDefaults.standard.integer(
            forKey: "RecipesSection")

    }

    // MARK:- Navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "recipeSegue") {
         let recipeViewController = segue.destination as! RecipeDetailViewController

        if let cell = sender as? UITableViewCell{
          let indexPath = tableView.indexPath(for: cell)
          if hasSearched{
              let searchResult = searchResults[indexPath!.row]
              recipeViewController.searchResult = searchResult
          }

        }
       }
       else if(segue.identifier == "restrictionsSegue") {
          let nav = segue.destination as! UINavigationController
          let destination = nav.topViewController as! RestrictionsTableViewController
          destination.delegate = self
       }
      }
    
    // instantiate detail recipe for collection view cell
    func moveOnRecipeDetail(index: Int) {
        guard let detailViewController = storyboard?.instantiateViewController(identifier: "RecipeDetailViewController") as? RecipeDetailViewController
        else{
            return
        }
        detailViewController.recommendedResult = recommendedResults[index]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    // MARK:- Helper Methods
    
    // URL object for API string
    func recipeURL(searchText: String) -> URL{
        // all the special characters(#,*,space) are escaped
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        var restriction = [String]()
        for i in restrictions{
            if i.checked{
                restriction.append(i.text.lowercased())
            }
        }
        
        if !restriction.isEmpty {
            var urlString = String(
            format: "https://api.edamam.com/api/recipes/v2?type=public&q=%@&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a", encodedText)
            var label = ""
            
            for i in restriction{
                label = i
                if i == restriction.first{
                    urlString += "&health=\(label)"
                }
                else{
                    urlString += "&\(label)"
                }
            }
            let url = URL(string: urlString)
            print(url!)
            return url!
        }
        else{
            let urlString = String(
            format: "https://api.edamam.com/api/recipes/v2?type=public&q=%@&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a", encodedText)
            let url = URL(string: urlString)
            return url!
        }
    }
    
    // returns string object with the data received from the server from URL
    func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        }
        catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func parse(data: Data) -> [SearchRecipesResults] {
      do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(
          ResultArray.self, from: data)
        
        return result.hits
        
      } catch {
        print("JSON Error: \(error)")
        return []
      }
    }
    
    // presents an alert controller with an error message.
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message: "There was an error accessing the recipes." +
            " Please try again.",
            preferredStyle: .alert)

        let action = UIAlertAction(
            title: "OK", style: .default, handler: nil)
            alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK:- Search Bar Delegate
extension SearchRecipesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if !searchBar.text!.isEmpty
        {
            searchBar.resignFirstResponder() // dismiss keyboard
            dataTask?.cancel()
            tableView.reloadData()
            
            hasSearched = true
            searchResults = []
            
            // get URL object from API
            let url = recipeURL(searchText: searchBar.text!)
            print("URL: '\(url)'")
            if let data = performStoreRequest(with: url) {
              let results = parse(data: data)
              print("Got results: \(results)")
            }
    
            let session = URLSession.shared
            // returns the JSON data that is received from the server URL
            dataTask = session.dataTask(with: url, completionHandler: {
                data, response, error in
                if let error = error as NSError?, error.code == -999 {
                  return
                } else if let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 {
                    if let data = data {
                      self.searchResults = self.parse(data: data)
                      DispatchQueue.main.async {
                        self.tableView.reloadData()
                      }
                      return
                    }
                } else {
                  print("Failure! \(response!)")
                }
                DispatchQueue.main.async {
                  self.hasSearched = false
                  self.tableView.reloadData()
                  self.showNetworkError()
                }
              })
            dataTask?.resume()
        }
    }
    
    // go back to trending page when search is cleared
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.hasSearched = false
                self.tableView.reloadData()
                self.viewDidLoad()
            }
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchResultText = searchBar.text!
    }
}

// MARK:- Table View Delegate

// handles all the table view related delegate methods.
extension SearchRecipesViewController: UITableViewDelegate, UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 1
        }

        else if searchResults.count == 0{
            return 1
        } else{
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if hasSearched && searchResults.count == 0 {
          return tableView.dequeueReusableCell(
            withIdentifier: TableView.CellIdentifiers.noRecipesFoundCell,for: indexPath)
        }
        else {
            if hasSearched{
                let cell = tableView.dequeueReusableCell(
                  withIdentifier: TableView.CellIdentifiers.searchRecipesResultCell,
                for: indexPath) as! SearchRecipesResultCell
                
                let searchResult = searchResults[indexPath.row]
                cell.recipeNameLabel!.text = searchResult.recipe.label
                cell.recipeDescriptionLabel!.text = searchResult.recipe.source

                cell.configure(for: searchResult)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "RecommendedTableViewCell", for: indexPath) as! RecommendedTableViewCell
                cell.recommendedRecipe = recommendedResults
                cell.index = indexPath.row
                cell.didSelectRecipeClosure = { rIndex in
                    if let recipeIndex = rIndex{
                        self.moveOnRecipeDetail(index: recipeIndex)
                    }
                }
                return cell
                }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 600
    }

    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if hasSearched{
            return "\(searchResultText) Recipes"
        }
        else {
            return "Recommended Recipes"
        }
    }
}
