//
//  NewsViewModel.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit
import AlamofireImage

final class NewsViewModel {
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
    var title: String {
        return news.title
    }
    
    var description: String {
        return news.desc
    }
    
    var link: URL {
        return news.link
    }
    
    var imageURL: URL {
        return news.imageURL
    }
    
    func configure(_ cell: NewsCell) {
        cell.newsImageView.af_setImage(withURL: self.imageURL)
        cell.newsTitle.text = self.title
        cell.newsDescription.text = self.description
    }
}
