//
//  AlamofireManager.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 05/07/21.
//

import Foundation

import Alamofire

enum webMethod: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

@available(iOS 12.0, *)
class AlamofireManager {
    
    static let sharedInstance = AlamofireManager()
    var headers = HTTPHeaders()
    
    private func setAutorizationHeader() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        guard let tokenType = UserDefaults.standard.string(forKey: "tokenType") else { return }
        headers["Authorization"] = tokenType + " " + accessToken
    }
    
    private func setSimpleHeader() {
        guard let apiKey = UserDefaults.standard.string(forKey: "apiKey") else { return }
        headers = ["api_key": apiKey]
    }
    
    func serviceWith<E: Encodable>(url: String, method: webMethod, parameters: E?, auth: Bool, onCompletion: @escaping ((_ response: Data?, _ error: NSError?) -> ())) {
        setSimpleHeader()
        if auth {
            setAutorizationHeader()
        }
        AF.request(url, method: Alamofire.HTTPMethod(rawValue: method.rawValue), parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON(queue: DispatchQueue.global(), completionHandler: { alamoResponse in
            switch alamoResponse.result {
            case .success( _):
                guard let jsonData = alamoResponse.data else {
                    onCompletion(nil, NSError(domain: "AlamofireManager", code: -3, userInfo: ["ErrorType" : "Without data"]))
                    return
                }
                onCompletion(jsonData, nil)
                return
            case .failure( _):
                onCompletion(nil, NSError(domain: "AlamofireManager", code: alamoResponse.response?.statusCode ?? -2, userInfo: ["ErrorType" : "Response failed for service"]))
                return
            }
        })
    }
}

