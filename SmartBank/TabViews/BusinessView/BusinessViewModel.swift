//
//  SportViewModel.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import Alamofire
import Combine

class BusinessViewModel: ObservableObject {
    
    @Published var sportData: MainDataDTO?
    @Published var sportDataList: [ArticleDTO] = [ArticleDTO]()

    
    private var task: Cancellable? = nil
    
    private let baseUrl = "https://newsapi.org/v2/"

    
    func fetchSportData() {
        guard let url = URL(string: baseUrl + "top-headlines?category=business&apiKey=45ad8e594a444b6e8f9a6a88a1bf2ab7") else { return }
        
        self.task = AF.request(url, method: .get, parameters: nil)
            .publishDecodable(type: MainDataDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                    
                case .finished:
                    print("")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                switch response.result {
                    
                case .success(let model):
                    self?.sportDataList = model.articles ?? []
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}
