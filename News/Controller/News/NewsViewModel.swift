//
//  NewViewModel.swift
//  NewViewModel
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import Foundation

class NewsViewModel {
    
    var news: [News] = []
    
    func loadAPI(completion: @escaping Completion) {
        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f6e0281842cc4472a61beb2fc247c0ea"
        Networking.shared().request(url: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSON()
                    let articles = json["articles"] as! [JSON]
                    
                    for item in articles {
                        let articles = News(json: item)
                        self.news.append(articles)
                        
                        completion(true, "")
                    }
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
    }
}
