//
//  ApiManager.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    func getCategory(completion: @escaping ([FoodCategory]?) -> Void) {
        
        let urlString = "https://vkus-sovet.ru/api/getMenu.php"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error: \(error)")
                        completion(nil)
                        return
                    }
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(CategoryResponse.self, from: data)
                            completion(response.menuList)
                        } catch {
                            print("Error: \(error)")
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
    
    func getName(menuID: String, completion: @escaping ([FoodName]?) -> Void) {
        
        let urlString = "https://vkus-sovet.ru/api/getSubMenu.php"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = "menuID=\(menuID)".data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error: \(error)")
                        completion(nil)
                        return
                    }
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(NameResponse.self, from: data)
                            completion(response.menuList)
                        } catch {
                            print("Error: \(error)")
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
}
