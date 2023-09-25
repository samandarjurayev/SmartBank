//
//  SaveHomeData.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import RealmSwift

extension DatabaseManager {
    
     func getDataStorageModel() -> DataStorageModel? {
        if let object = DatabaseManager.shared.realm?.objects(DataStorageModel.self).first {
            return DataStorageModel(value: object)
        }
        
        return nil
    }
    
    func saveDataStorageModel(object: DataStorageModel) {
        self.removeDataStorageModel()
                
        DatabaseManager.shared.insertToRealm(object: object)
    }
    
    func removeDataStorageModel() {
        DatabaseManager.shared.deleteFromRealm(DataStorageModel.self)
    }
}

extension DatabaseManager {
    func saveingHomeData(data: MainDataDTO?) {
        
        guard let homeData = data else { return }
        
        let dataStorageModel = DataStorageModel()
        
        dataStorageModel.status = data?.status
        dataStorageModel.totalResults = data?.totalResults
        
        if let artecles = homeData.articles {
            
            var list = List<ArticleStorageModel>()
            
            for item in artecles {
                
                let articleStorageModel = ArticleStorageModel()
                
                let sourceStorageModel = SourceStorageModel()
                
                if let source = item.source {
                    sourceStorageModel.id = source.id
                    sourceStorageModel.name = source.name
                }
                
                articleStorageModel.author = item.author
                articleStorageModel.title = item.title
                articleStorageModel.desc = item.description
                articleStorageModel.url = item.url
                articleStorageModel.urlToImage = item.urlToImage
                articleStorageModel.publishedAt = item.publishedAt
                articleStorageModel.content = item.content
                
                list.append(articleStorageModel)
            }
            
            dataStorageModel.articles = list
        }
        
        saveDataStorageModel(object: dataStorageModel)
    }
    
    func getMainDataDTO() -> MainDataDTO? {
        
        guard let data = getDataStorageModel() else { return nil }
        
        let sacedArticles = data.articles
        
        var articles = [ArticleDTO]()
        
        for item in sacedArticles {
            
            var articleDTO = ArticleDTO()
            
            var sourceDTO = SourceDTO()
            
            if let source = item.source {
                sourceDTO.id = source.id
                sourceDTO.name = source.name
            }
            
            articleDTO.author = item.author
            articleDTO.title = item.title
            articleDTO.description = item.desc
            articleDTO.url = item.url
            articleDTO.urlToImage = item.urlToImage
            articleDTO.publishedAt = item.publishedAt
            articleDTO.content = item.content
            
            articles.append(articleDTO)
        }
        
        let  mainData = MainDataDTO(status: data.status, totalResults: data.totalResults, articles: articles)
        
        return mainData
    }
    
}

