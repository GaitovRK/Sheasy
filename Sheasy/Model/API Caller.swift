//
//  API Caller.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 29.05.2022.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    let API_Key = "ede0ea6a7ba1bd268513c60665786642"
    let APP_ID = "e92ce914"
    
    struct Constants {
        static let randomRecipesURL = URL(string: "https://api.edamam.com/search?q=soup&app_id=e92ce914&app_key=ede0ea6a7ba1bd268513c60665786642")
    }
    
    private init() { }
    
    public func getRecipes(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url1 = Constants.randomRecipesURL else {
            return
        }
    
    let task = URLSession.shared.dataTask(with: url1) { data, _, error in
        if let error = error {
            completion(.failure(error))
        }
        else if let data = data {
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                
                print("Recipes: \(result.recipes.count)")
            }
            catch {
                completion(.failure(error))
            }
        }
    }
    task.resume()
    }
}

struct APIResponse: Codable {
    let recipes: [Recipe]
}
