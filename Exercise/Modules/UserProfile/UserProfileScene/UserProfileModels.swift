//
//  UserProfileModels.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

enum UserProfile {
    
    // MARK: Use cases
    
    enum Info {
        
        // User Profile Information
        
        struct ResponseWSModel: Codable {
            var email: String
            var firstName: String
            var lastName: String
            var phoneNumber: String
            var profilePicture: String
            var cardNumber: String
            
            enum CodingKeys: String, CodingKey {
                case email = "email"
                case firstName = "first_name"
                case lastName = "last_name"
                case phoneNumber = "phone_number"
                case profilePicture = "profile_picture"
                case cardNumber = "card_number"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                email = try container.decode(String.self, forKey: .email)
                firstName = try container.decode(String.self, forKey: .firstName)
                lastName = try container.decode(String.self, forKey: .lastName)
                phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
                profilePicture = try container.decode(String.self, forKey: .profilePicture)
                cardNumber = try container.decode(String.self, forKey: .cardNumber)
            }
            
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(email, forKey: .email)
                try container.encode(firstName, forKey: .firstName)
                try container.encode(lastName, forKey: .lastName)
                try container.encode(phoneNumber, forKey: .phoneNumber)
                try container.encode(profilePicture, forKey: .profilePicture)
                try container.encode(cardNumber, forKey: .cardNumber)
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

enum UserCard {
    
    // MARK: Use cases
    
    enum Info {
        
        // User Card Information
        
        struct RequestModel {
            var cardNumber: String
        }
        
        struct RequestWSModel: Encodable {
            var card_number: String
            var country_code: String
            var pin: String
            var transaction_include: Bool
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
        
        struct ViewCardModel {
            var email: String
            var name: String
            var profilePicture: String
            var cardNumber: String
        }
    }
}

