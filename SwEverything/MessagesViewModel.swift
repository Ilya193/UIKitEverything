//
//  MainViewModel.swift
//  SwEverything
//
//  Created by ilya on 30.06.2024.
//

import Foundation   

class MessagesViewModel {
    
    var onDataUpdate: (() -> Void)?
    var messages: [PostUi] = [] {
        didSet {
            onDataUpdate?()
        }
    }
    
    func fetchPosts() {
        if let url = URL(string: "http://jsonplaceholder.typicode.com/posts") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        self.messages = try decoder.decode([PostUi].self, from: data)
                    } catch let error {
                        print("Ошибка")
                    }
                }
            }.resume()
        }
    }
}

struct PostUi : Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
