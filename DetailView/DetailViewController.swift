//
//  ViewController.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/25/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var textLabel:String = "Title"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoader(onView: self.view)

        titleLabel.text = textLabel
        delegate = self
        
        let origImage = UIImage(named: "back")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .white
        
        backButton.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        
        getData()
    }
    
    @objc func back(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getData() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = .init(identifier: "es_ES")
        let date = dateFormatter.date(from: textLabel)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        getApod(date: dateFormatter.string(from: date!))
    }
    
}

extension DetailViewController {
    func configView(imageUrl: String, text: String) {
        self.textView.text = text
        
        if !imageUrl.isEmpty {
            self.load(url: URL(string: imageUrl)!)
        }
        
        self.removeLoader()
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let imag = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self!.imageView.image = imag
                    }
                }
            }
        }
    }
    
    func alertReLoad() {
        let alert = UIAlertController(title: AlertText.title, message: AlertText.errorMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: AlertText.cancelAction, style: UIAlertAction.Style.destructive, handler: {
            _ in
        }))
        alert.addAction(UIAlertAction(title: AlertText.doAction, style: UIAlertAction.Style.default,handler: {
            _ in self.getData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController: ResponseDelegate {
    func didFinish(finishLoad response:(Response, apodResponse?)) {
        switch response.0 {
        case .success:
            self.configView(imageUrl: response.1?.url ?? URLS.imageDefault , text: response.1?.explanation ?? EmptyText.emptyExplanation)
        case .failure:
            self.removeLoader()
            alertReLoad()
        }
    }
}
