//
//  HomeDTO.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 21/09/23.
//

import Foundation

struct MainDataDTO: Hashable, Codable {
   
    internal init(status: String? = nil, totalResults: Int? = nil, articles: [ArticleDTO]? = nil) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
    
    var status: String?
    var totalResults: Int?
    var articles: [ArticleDTO]?
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        status = try? container?.decode(String.self, forKey: .status)
        totalResults = try? container?.decode(Int.self, forKey: .totalResults)
        articles = try? container?.decode([ArticleDTO].self, forKey: .articles)
    }
    
    enum CodingKeys: CodingKey {
        case status, totalResults, articles
    }
}

struct ArticleDTO: Hashable, Codable {
    internal init(source: SourceDTO? = nil, author: String? = nil, title: String? = nil, description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    var id = UUID()
    var source: SourceDTO?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        source = try? container?.decode(SourceDTO.self, forKey: .source)
        author = try? container?.decode(String.self, forKey: .author)
        title = try? container?.decode(String.self, forKey: .title)
        description = try? container?.decode(String.self, forKey: .description)
        url = try? container?.decode(String.self, forKey: .url)
        urlToImage = try? container?.decode(String.self, forKey: .urlToImage)
        publishedAt = try? container?.decode(String.self, forKey: .publishedAt)
        content = try? container?.decode(String.self, forKey: .content)
    }
    
    enum CodingKeys: CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}

struct SourceDTO: Hashable, Codable {
    internal init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    var id: Int?
    var name: String?
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container?.decode(Int.self, forKey: .id)
        name = try? container?.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: CodingKey {
        case id, name
    }
}
