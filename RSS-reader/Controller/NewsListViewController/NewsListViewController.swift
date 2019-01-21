//
//  NewsListViewController.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {
    
    internal var news: [News] = []
    internal var selectedNews: News!
    private let url: URL = URL(string: "https://cointelegraph.com/rss")!
    private var manager: XmlParserManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        manager = XmlParserManager(url: url)
        manager.delegate = self
        
        self.reloadData(self)
    }
    
    @objc func reloadData(_ sender: Any) {
        manager.startParse()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailNews" {
            if let vc: DetailNewsViewController = segue.destination as? DetailNewsViewController {
                vc.news = self.selectedNews
            }
        }
    }

}

extension NewsListViewController: XmlParserManagerDelegate {
    func didEndParsingDocument(_ parserManager: XmlParserManager) {
        self.news = parserManager.newsArray
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
}
