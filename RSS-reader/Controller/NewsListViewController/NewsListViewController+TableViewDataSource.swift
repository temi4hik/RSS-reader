//
//  NewsListViewController+TableViewDataSource.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit


// MARK: Table view data source
extension NewsListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let news = self.news[indexPath.row]
        let viewModel = NewsViewModel(news: news)
        
        viewModel.configure(cell)
        
        return cell
    }
}
