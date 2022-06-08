//
//  URLSession.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 01.06.2022.
//

import Foundation

struct ResultArray: Codable {
    var from: Int?
    var to: Int?
    var count: Int?
    var _links: [String?]
    var hits = [SearchRecipesResults]()
}

struct SearchRecipesResults: Codable {
    var recipe: Recipe
    
    struct Recipe: Codable {
        
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
            
        }
        
        struct Nutrients: Codable{
            var label: String? = ""
            var quantity: Double? = 0.0
            var unit: String? = ""
        }
    }
}

