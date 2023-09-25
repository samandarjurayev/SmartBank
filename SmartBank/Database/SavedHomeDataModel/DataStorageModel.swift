//
//  SavedHomeDataModel.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import RealmSwift

final class DataStorageModel: Object {
    
    @Persisted var status: String?
    @Persisted var totalResults: Int?
    @Persisted var articles: List<ArticleStorageModel>
}


final class ArticleStorageModel: Object {
    
    @Persisted var id = UUID()
    @Persisted var source: SourceStorageModel?
    @Persisted var author: String?
    @Persisted var title: String?
    @Persisted var desc: String?
    @Persisted var url: String?
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String?
    @Persisted var content: String?
}

final class SourceStorageModel: Object {
    @Persisted var id: Int?
    @Persisted var name: String?
}

