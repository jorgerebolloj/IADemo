//
//  LoginModels.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

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
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                accessToken = try container.decode(String.self, forKey: .accessToken)
                tokenType = try container.decode(String.self, forKey: .tokenType)
                expiresIn = try container.decode(Int.self, forKey: .expiresIn)
                refreshToken = try container.decode(String.self, forKey: .refreshToken)
                asClientId = try container.decode(String.self, forKey: .asClientId)
                username = try container.decode(String.self, forKey: .username)
                countryCode = try container.decode(String.self, forKey: .countryCode)
                issued = try container.decode(String.self, forKey: .issued)
                expires = try container.decode(String.self, forKey: .expires)
                
            }
            
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(accessToken, forKey: .accessToken)
                try container.encode(tokenType, forKey: .tokenType)
                try container.encode(expiresIn, forKey: .expiresIn)
                try container.encode(refreshToken, forKey: .refreshToken)
                try container.encode(asClientId, forKey: .asClientId)
                try container.encode(username, forKey: .username)
                try container.encode(countryCode, forKey: .countryCode)
                try container.encode(issued, forKey: .issued)
                try container.encode(expires, forKey: .expires)
            }
        }
    }
}
