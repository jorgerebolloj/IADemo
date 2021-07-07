//
//  LoginModels.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import RealmSwift

enum Login {
    
    // MARK: Use cases
    
    enum Auth {
        
        struct RequestModel {
            var username: String
            var password: String
        }
        
        struct RequestWSModel: Encodable {
            var country_code: String
            var username: String
            var password: String
            var grant_type: String
            var client_id: String
            var client_secret: String
        }
        
        struct ResponseWSModel: Codable {
            var accessToken: String
            var tokenType: String
            var expiresIn: Int
            var refreshToken: String
            var asClientId: String
            var username: String
            var countryCode: String
            var issued: String
            var expires: String

            enum CodingKeys: String, CodingKey {
                case accessToken = "access_token"
                case tokenType = "token_type"
                case expiresIn = "expires_in"
                case refreshToken = "refresh_token"
                case asClientId = "as:client_id"
                case username = "username"
                case countryCode = "country_code"
                case issued = ".issued"
                case expires = ".expires"
            }
        }
    }
}

@objcMembers
class LoginRLM: Object {
    dynamic var username: String = ""
    dynamic var password: String? = nil
    
    override static func primaryKey() -> String? {
        return "username"
    }
}
