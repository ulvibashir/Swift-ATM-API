//
//  API.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/8/20.
//

import Foundation
import Alamofire

struct API {
    static let url = URL(string: "https://mbanking-prod.ibar.az/api/v2/locator-svc/locators/")!
    static var request = URLRequest(url: url)
    
    static func getDataFromApi (lang: String, completion: @escaping (Data) -> ()) {
        request.httpMethod = "GET"
        request.setValue(lang.lowercased(), forHTTPHeaderField: "Accept-Language")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil {
                print(error ?? "error problem")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Data.self, from: data!)
                completion(json)
                print("API Request")
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
}

struct APIalamofire {
    static let url = "https://mbanking-prod.ibar.az/api/v2/locator-svc/locators/"
    static func getDataFromApi(lang: String, completion: @escaping (Data) -> ()) {
        let headers: HTTPHeaders = [
            .acceptLanguage(lang.lowercased())
        ]
        
        
        AF.request(url, headers: headers).responseJSON { response in
            if let jsonData = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let res = try jsonDecoder.decode(Data.self, from: jsonData)
                    completion(res)
                } catch let error {
                    print(error.localizedDescription)
                }
            }

        }
        
        
    }
}
