//
//  WebService.swift
//  NikeCodingAssingment
//
//  Created by Nitin Pabba on 9/10/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import Foundation

typealias MediaCompletion = ([Media]) -> Void

class WebService {
    
    private static let baseURL = "https://rss.itunes.apple.com/api/v1/us"
    
    static func loadiTunesMedia(completion: @escaping MediaCompletion) {
        let urlString = "\(self.baseURL)/apple-music/coming-soon/all/100/explicit.json"
        let url = URL(string: urlString)
        
        guard let guardedUrl = url else {
            return
        }
        
        self.getData(from: guardedUrl) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(decodedResponse.feed.results)
                } catch {
                    completion([Media]())
                }
            } else {
                completion([Media]())
            }
        }
    }
        
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func downloadData(from url: URL, completion: @escaping (URL?, URLResponse?, Error?) -> Void) -> Void {
        URLSession.shared.downloadTask(with: url, completionHandler: completion).resume()
    }
}
