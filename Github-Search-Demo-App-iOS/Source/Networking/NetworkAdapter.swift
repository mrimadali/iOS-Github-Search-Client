//
//  NetworkAdapter.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import Foundation
import UIKit
import SwiftyJSON
import Loaf

// MARK: - Struct GithubAPI Constants
struct GithubAPI {
    static let baseURL      = "https://api.github.com/"
    static let searchRepo   = "search/repositories"
    static let perPage      = "per_page"
    static let kPerPage     = 30
    static let page         = "page"
    static let error_403    = "Status: 403 Forbidden - API rate limit exceeded"
    static let error_422    = "Status: 422 Unprocessable Entity"
    static let error_unkown = "Status: Service Unavailable"
}

// MARK: - Network adapter class
class NetworkAdapter {
    
    // MARK: - Class private instances
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    let jsonDecoder = JSONDecoder()
    
    // MARK: - Github search API
    func githubSearchAPI(with query: String, pageNo: Int,sender: UIViewController, completion: @escaping (_ totalMovies: Int,[Item]?) -> Void) {
        dataTask?.cancel()
        let webURL = "\(GithubAPI.baseURL)\(GithubAPI.searchRepo)?\(GithubAPI.perPage)=\(GithubAPI.kPerPage)&\(GithubAPI.page)=\(pageNo)&q=\(query)"
        guard let url = URL(string: webURL) else {
            return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    Loaf(self?.errorMessage ?? "", state: .warning, sender: sender).show()
                } else if let data = data {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        if statusCode == 200 {
                            do {
                                let json = try JSON(data: data)
                                let itemRoot = ItemRoot()
                                itemRoot.copyDO(json)
                                completion(itemRoot.totalCount, itemRoot.items)
                                
                            } catch let jsonErr {
                                print("Error serializing json:", jsonErr)
                            }
                        }else if statusCode == 403 {
                            Loaf(GithubAPI.error_403, state: .warning, sender: sender).show()
                            completion(0, [])
                            
                        }else if statusCode == 422 {
                            Loaf(GithubAPI.error_422, state: .warning, sender: sender).show()
                            completion(0, [])
                            
                        }else {
                            Loaf(GithubAPI.error_unkown, state: .warning, sender: sender).show()
                            completion(0, [])
                        }
                    }
                    
                }
            }
        }
        dataTask?.resume()
    }
}
