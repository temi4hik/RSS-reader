//
//  News.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//


import UIKit

public final class News {
    let title: String
    let link: URL
    let desc: String
    let imageURL: URL
    
    public init(title: String, link: URL, desc: String, imageURL: URL) {
        self.title = title
        self.link = link
        self.desc = desc
        self.imageURL = imageURL
    }
}
