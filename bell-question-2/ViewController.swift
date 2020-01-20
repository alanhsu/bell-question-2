//
//  ViewController.swift
//  bell-question-2
//
//  Created by Alan Hsu on 2020-01-19.
//  Copyright © 2020 Alan Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
            let alert = UIAlertController(title: "Last Modified Date Time", message: dateFormatter.string(from: lastModifiedDate), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

