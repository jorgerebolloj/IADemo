//
//  Endpoints.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 05/07/21.
//

import Foundation

struct Endpoints {
    static var domain : Domains {
        return .urlAPI
    }
    
    static let login = Domains.urlAPI.rawValue + "v2/oauth/token"
    static let userProfile = Domains.urlAPI.rawValue + "v1/members/profile?country_code=MX"
    static let cardTransactions = Domains.urlAPI.rawValue + "v1/members/loyalty/"
    static let billboard = Domains.urlAPI.rawValue + "v2/movies?country_code=MX&cinema=61"
}
