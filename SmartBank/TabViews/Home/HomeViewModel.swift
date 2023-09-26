//
//  ViewModel.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class HomeViewModel: NSObject, ObservableObject {
    
    @Published var homeData: MainDataDTO?
    @Published var homeDataList: [ArticleDTO] = [ArticleDTO]()
    @Published var searchIngText: String =  ""
    
    
    private var task: Cancellable? = nil
    
    private let baseUrl = "https://newsapi.org/v2/"
    
    func fetchHomeData() {
        
        guard let url = URL(string: baseUrl + "top-headlines?country=us&apiKey=45ad8e594a444b6e8f9a6a88a1bf2ab7") else { return }
        
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
                    self?.homeDataList = model.articles ?? []
                    
                    self?.saveingHomeData(data: model)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        
    }
    
    private func saveingHomeData(data: MainDataDTO) {
        DatabaseManager.shared.saveingHomeData(data: data)
    }
    
    func fetchFromDatabase() -> [ArticleDTO] {
        if let homeData = DatabaseManager.shared.getMainDataDTO(), let articles = homeData.articles  {
            
            return articles
        }
        
        return []
    }
}

// MARK: - For searchin data
extension HomeViewModel {
    func fetchSearchingResult(text: String) {
        
        if text.isEmpty {
            fetchHomeData()
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(textDidChange(text:)), object: text)
        self.perform(#selector(textDidChange(text:)), with: text, afterDelay: 1)
    }
    
    @objc func textDidChange(text: String) {
        
        guard let url = URL(string: baseUrl + "everything?q=" + text + "&apiKey=30bab526ed854fdc815c2aa02f19a53e") else { return }
        
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
                    self?.homeDataList = model.articles ?? []
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}
