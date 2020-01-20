//
//  viewModel.swift
//  bell-question-2
//
//  Created by Alan Hsu on 2020-01-19.
//  Copyright © 2020 Alan Hsu. All rights reserved.
//

import Foundation

class MainViewControllerViewModel: NSObject {
    
    var sessionTask: URLSessionTask?
    
    // Observable property to allow the UI to reactive to any changes to this property
    @objc dynamic var lastModifiedDate: String?
    
    func fetchContent() {
        guard let url = URL(string: "https://capi.stage.9c9media.com/destinations/tsn_ios/platforms/iPad/contents/69585") else { return }
        
        let request = URLRequest(url: url)
        sessionTask = URLSession.shared.dataTask(with: request, completionHandler: {[weak self] (data, response, error) in
            guard let data = data, error == nil, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            let lastModfied = json?["LastModifiedDateTime"] as? String
            self?.lastModifiedDate = lastModfied
        })
        
        sessionTask?.resume()
    }
}
