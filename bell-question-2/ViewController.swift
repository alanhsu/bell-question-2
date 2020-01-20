//
//  ViewController.swift
//  bell-question-2
//
//  Created by Alan Hsu on 2020-01-19.
//  Copyright © 2020 Alan Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lastModifiedDateLabel: UILabel!
    
    var lastModifiedDateObserver: NSKeyValueObservation?
    let viewModel = MainViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup observer to automatically react to view model changes
        lastModifiedDateObserver = viewModel.observe(\.lastModifiedDate, options: [.old, .new], changeHandler: { (_, change) in
            guard let lastModifiedDateString = change.newValue else { return }
            DispatchQueue.main.async {
                self.show(lastModifiedDate: lastModifiedDateString)
            }
        })
    }

    @IBAction func fetchButtonDidTap(_ sender: Any) {
        viewModel.fetchContent()
    }
    
    func show(lastModifiedDate date: String?) {
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let lastModifiedDate = dateFormatter.date(from: date) {
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .medium
            self.lastModifiedDateLabel.text = dateFormatter.string(from: lastModifiedDate)
        }
    }
}

