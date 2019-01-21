//
//  XmlParserManager.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation

@objc protocol XmlParserManagerDelegate {
    
    @objc optional func didStartParsingDocument(_ parserManager: XmlParserManager)
    
    @objc optional func didEndParsingDocument(_ parserManager: XmlParserManager)
}

class XmlParserManager: NSObject, XMLParserDelegate {
    private let parser: XMLParser
    var newsArray: [News]
    
    weak var delegate: XmlParserManagerDelegate?
    
    private var feeds = [[String:String]]()
    private var elements = [String:String]()
    private var element = String()
    private var ftitle = String()
    private var link = String()
    private var img = String()
    private var fdescription = String()
    
    init(url: URL) {
        self.parser = XMLParser(contentsOf: url)!
        self.newsArray = []
    }
    
    func startParse() {
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.element = elementName
        
        if element == "item" {
            elements = [:]
            ftitle = ""
            link = ""
            fdescription = ""
            img = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img = urlString
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if ftitle != "" {
                elements["title"] = ftitle
            }
            if link != "" {
                elements["link"] = link
            }
            if fdescription != "" {
                elements["description"] = fdescription
            }
            if img != "" {
                elements["img"] = img
            }
            
            feeds.append(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element == "title" {
            ftitle += string
        } else if element == "link" {
            link += string
        } else if element == "description" {
            fdescription += string
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        for el in self.feeds {
            
            let title: String = el["title"]!.trimmingCharacters(in: .whitespacesAndNewlines)
            var linkStr = el["link"]!
            
            // Removing extra symbols from link
            linkStr = String(linkStr.filter { !" \n\t\r".contains($0) })
            let link: URL = URL(string: linkStr)!
            
            var description: String = el["description"]!
            
            // Removing html tags
            description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespacesAndNewlines)
            
            let imageStr: String = el["img"]!
            let imageUrl: URL = URL(string: imageStr)!
            
            
            let news = News(title: title, link: link, desc: description, imageURL: imageUrl)
            
            
            self.newsArray.append(news)
        }
        if let delegate = self.delegate {
            delegate.didEndParsingDocument!(self)
        }
    }
}


