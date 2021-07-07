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
        }
        
        struct ViewCardModel {
            var email: String
            var name: String
            var profilePicture: String
            var cardNumber: String
        }
    }
}

