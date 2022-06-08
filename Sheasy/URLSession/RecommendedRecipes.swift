//
//  RecommendedRecipes.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 05.06.2022.
//

import Foundation

struct RecommendationRecipes: Codable{
    var from: Int
    var to: Int
    var count: Int
    var _links: [String: [String: String]]
    var hits = [RecommendationResults]()
}
struct RecommendationResults: Codable {
    var recipe: Recipe
    
    struct Recipe: Codable
    {
        var label: String?
        var source: String?
        var image: String?
        var url: String?
        var yield: Double?
        var dietLabels = [String?]()
        var healthLabels = [String?]()
        var ingredientLines = [String?]()
        var calories: Double?
        var totalTime: Double?
        var cuisineType = [String?]()
        var mealType = [String?]()
        var dishType = [String?]()
        var totalNutrients: TotalNutrients
        var totalDaily: TotalDaily
        
        struct TotalNutrients: Codable {
            var kcals: Nutrients?
            var fat: Nutrients?
            var satFat: Nutrients?
            var transFat: Nutrients?
            var monoFat: Nutrients?
            var polyunFat: Nutrients?
            var carbs: Nutrients?
            var fiber: Nutrients?
            var sugars: Nutrients?
            var protein: Nutrients?
            var cholesterol: Nutrients?
            var NA: Nutrients?
            var CA: Nutrients?
            var MG: Nutrients?
            var K: Nutrients?
            var FE: Nutrients?
            var ZN: Nutrients?
            var P: Nutrients?
            var vitaminA: Nutrients?
            var vitaminC: Nutrients?
            var thiamin: Nutrients?
            var riboflavin: Nutrients?
            var niacin: Nutrients?
            var vitaminB6: Nutrients?
            var vitaminB12: Nutrients?
            var vitaminD: Nutrients?
            var vitaminE: Nutrients?
            var vitaminK: Nutrients?
            
            enum CodingKeys: String, CodingKey {
                case kcals = "ENERC_KCAL"
                case fat = "FAT"
                case satFat = "FASAT"
                case transFat = "FATRN"
                case monoFat = "FAMS"
                case polyunFat = "FAPU"
                case carbs = "CHOCDF"
                case fiber = "FIBTG"
                case sugars = "SUGAR"
                case protein = "PROCNT"
                case cholesterol = "CHOLE"
                case vitaminA = "VITA_RAE"
                case vitaminC = "VITC"
                case thiamin = "THIA"
                case riboflavin = "RIBF"
                case niacin = "NIA"
                case vitaminB6 = "VITB6A"
                case vitaminB12 = "VITB12"
                case vitaminD = "VITD"
                case vitaminE = "TOCPHA"
                case vitaminK = "VITK1"
                case NA, CA, MG
                case K, FE, ZN
                case P
            }
        }
        struct TotalDaily: Codable {
            var kcals: Nutrients?
            var fat: Nutrients?
            var satFat: Nutrients?
            var transFat: Nutrients?
            var monoFat: Nutrients?
            var polyunFat: Nutrients?
            var carbs: Nutrients?
            var fiber: Nutrients?
            var sugars: Nutrients?
            var protein: Nutrients?
            var cholesterol: Nutrients?
            var NA: Nutrients?
            var CA: Nutrients?
            var MG: Nutrients?
            var K: Nutrients?
            var FE: Nutrients?
            var ZN: Nutrients?
            var P: Nutrients?
            var vitaminA: Nutrients?
            var vitaminC: Nutrients?
            var thiamin: Nutrients?
            var riboflavin: Nutrients?
            var niacin: Nutrients?
            var vitaminB6: Nutrients?
            var vitaminB12: Nutrients?
            var vitaminD: Nutrients?
            var vitaminE: Nutrients?
            var vitaminK: Nutrients?
            
            enum CodingKeys: String, CodingKey {
                case kcals = "ENERC_KCAL"
                case fat = "FAT"
                case satFat = "FASAT"
                case transFat = "FATRN"
                case monoFat = "FAMS"
                case polyunFat = "FAPU"
                case carbs = "CHOCDF"
                case fiber = "FIBTG"
                case sugars = "SUGAR"
                case protein = "PROCNT"
                case cholesterol = "CHOLE"
                case vitaminA = "VITA_RAE"
                case vitaminC = "VITC"
                case thiamin = "THIA"
                case riboflavin = "RIBF"
                case niacin = "NIA"
                case vitaminB6 = "VITB6A"
                case vitaminB12 = "VITB12"
                case vitaminD = "VITD"
                case vitaminE = "TOCPHA"
                case vitaminK = "VITK1"
                case NA, CA, MG
                case K, FE, ZN
                case P
            }
        }
        
        struct Nutrients: Codable{
            var label: String? = ""
            var quantity: Double? = 0.0
            var unit: String? = ""
        }
    }
}

extension RecommendationRecipes {
    static func recommendationRecipies() -> [RecommendationResults]{
        guard
            let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=Recommended&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a"),
            let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        do {
          let decoder = JSONDecoder()
            let result = try decoder.decode(RecommendationRecipes.self, from: data)
            return result.hits
        } catch {
          return []
        }
    }
}
