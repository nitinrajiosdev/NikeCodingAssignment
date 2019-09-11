//
//  MediaViewModel.swift
//  NikeCodingAssingment
//
//  Created by Nitin Pabba on 9/10/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import Foundation
import UIKit

struct Response: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var results: [Media]
}

struct Genre: Codable, Equatable {
    var name: String
}

struct Media: Codable {
    var name: String
    var imageURL: String
    var artistName: String
    var releaseDate: String
    var genres: [Genre]
    var copyright: String
    var iTunesURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageURL = "artworkUrl100"
        case artistName = "artistName"
        case releaseDate = "releaseDate"
        case genres = "genres"
        case copyright = "copyright"
        case iTunesURL = "url"
    }
}

typealias ImageCompletion = (UIImage?) -> Void

class MediaViewModel {
    typealias NotifyBlock = () -> Void
    var mediaArray: [Media]? {
        didSet {
            notifyWhenDataComplete?()
        }
    }
    var notifyWhenDataComplete: NotifyBlock?
    
    private(set) lazy var imageCache: [String: UIImage?] = {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleMemoryWarningNotification), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
        return [:]
    }()
    
    // MARK: - Public
    
    func getMedia() {
        WebService.loadiTunesMedia { (responseArray) in
            self.mediaArray = responseArray
        }
    }
    
    func getMedia(atIndexPath indexPath: IndexPath) -> Media? {
        guard indexPath.row >= 0 && indexPath.row < self.mediaArray?.count ?? 0 else {
            return nil
        }
        return self.mediaArray?[indexPath.row]
    }
    
    func getImage(forMedia media: Media?, completion: @escaping ImageCompletion) -> Void {
        guard let urlString = media?.imageURL else {
            completion(nil)
            return
        }
        if let cachedImage = self.imageCache[urlString] {
            completion(cachedImage)
            return
        }
        guard let url = URL.init(string: urlString) else {
            completion(nil)
            return
        }
        WebService.getData(from: url, completion: { [weak self] (data, _, _) in
            if let data = data, let image = UIImage.init(data: data) {
                self?.imageCache[urlString] = image
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        })
    }
    
    // MARK: - Notification Center Obsevers
    
    @objc private func handleMemoryWarningNotification(_ notification: Notification) -> Void {
        self.imageCache = [:]
    }
}

