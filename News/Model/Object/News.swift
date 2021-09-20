//
//  News.swift
//  News
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import Foundation
import UIKit

class News {
    var author: String?
    var title: String?
    var url: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var thumbnailImage: UIImage?
    
    init(json: JSON) {
        self.author = json["author"] as? String
        self.title = json["title"] as? String
        self.url = json["url"] as? String
        self.description = json["description"] as? String
        self.urlToImage = json["urlToImage"] as? String
        self.publishedAt = json["publishedAt"] as? String
        self.content = json["content"] as? String
    }
}
