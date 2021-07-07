//
//  BillboardModels.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

enum Billboard {
    
    // MARK: Use cases
    
    enum Info {
        
        struct ResponseWSModel: Codable {
            var movies: [Movie]
            var routes: [Route]
        }
        
        struct Movie: Codable {
            var rating: String
            var media: [Media]
            var cast: [Cast]
            var cinemas: [String]?
            var position: Int
            var categories: [String]
            var genre: String
            var synopsis: String
            var length: String
            var releaseDate: String
            var distributor: String
            var id: Int
            var name: String
            var code: String
            var originalName: String
            
            enum CodingKeys: String, CodingKey {
                case rating = "rating"
                case media = "media"
                case cast = "cast"
                case cinemas = "cinemas"
                case position = "position"
                case categories = "categories"
                case genre = "genre"
                case synopsis = "synopsis"
                case length = "length"
                case releaseDate = "release_date"
                case distributor = "distributor"
                case id = "id"
                case name = "name"
                case code = "code"
                case originalName = "original_name"
            }
        }
        
        struct Media: Codable {
            var resource: String
            var type: String
            var code: String
        }
        
        struct Cast: Codable {
            var label: String
            var value: [String]
        }
        
        struct Route: Codable {
            var code: String
            var sizes: Size
        }
        
        struct Size: Codable {
            var large: String?
            var medium: String?
            var small: String?
            var xLarge: String?
            
            enum CodingKeys: String, CodingKey {
                case large = "large"
                case medium = "medium"
                case small = "small"
                case xLarge = "x-large"
            }
        }
        
        struct ViewModel {
            var email: String
            var name: String
            var profilePicture: String
            var cardNumber: String
        }
    }
}
