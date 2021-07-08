//
//  BillboardModels.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import RealmSwift

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
            var cinemas: [String]? = nil
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
            var large: String? = nil
            var medium: String? = nil
            var small: String? = nil
            var xLarge: String? = nil
            
            enum CodingKeys: String, CodingKey {
                case large = "large"
                case medium = "medium"
                case small = "small"
                case xLarge = "x-large"
            }
        }
        
        struct ViewModel {
            var name: String
            var poster: String
        }
        
        struct RoutesModel {
            var poster: String
            var backgroundSynopsis: String
            var trailerMp4: String
            var posterHorizontal: String
            var ribbon: String
        }
    }
}

// RealmSwift Entity

@objcMembers
final class BillboardRLM: Object {
    dynamic var id: String = ""
    var movies = List<MovieRLM>()
    var routes = List<RouteRLM>()
    
    internal override class func primaryKey() -> String {
        return "id"
    }
}

@objcMembers
final class MovieRLM: Object {
    dynamic var rating: String = ""
    var media = List<MediaRLM>()
    var cast = List<CastRLM>()
    dynamic var position: Int = 0
    var categories = List<String>()
    dynamic var genre: String = ""
    dynamic var synopsis: String = ""
    dynamic var length: String = ""
    dynamic var releaseDate: String = ""
    dynamic var distributor: String = ""
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var code: String = ""
    dynamic var originalName: String = ""
    
    private enum CodingKeys: String, CodingKey {
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
    
    internal override static func primaryKey() -> String? {
        return "position"
    }
}

@objcMembers
final class MediaRLM: Object {
    dynamic var id: String = ""
    dynamic var resource: String = ""
    dynamic var type: String = ""
    dynamic var code: String = ""
    
    internal override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
final class CastRLM: Object {
    dynamic var id: String = ""
    dynamic var label: String = ""
    var value = List<String>()
    
    internal override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
final class RouteRLM: Object {
    dynamic var code: String = ""
    var sizes = List<SizeRLM>()
    
    internal override static func primaryKey() -> String? {
        return "code"
    }
}

@objcMembers
final class SizeRLM: Object {
    dynamic var id: String = ""
    dynamic var large: String? = nil
    dynamic var medium: String? = nil
    dynamic var small: String? = nil
    dynamic var xLarge: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case small = "small"
        case xLarge = "x-large"
    }
    
    internal override class func primaryKey() -> String {
        return "id"
    }
}
