//
//  ViewController.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/25/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!

    var selectedDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showLoader(onView: self.view)

        titleLabel.text = "Cargando"

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
        HTTPClient.shared.getAPOD(for: selectedDate) { [weak self] (response) in
            guard let apodInfo = response else {
                print("Error fetching APOD response!")
                self?.titleLabel.text = "Error :("
                return
            }

            self?.titleLabel.text = apodInfo.title
            self?.configView(imageUrl: apodInfo.url ?? URLS.imageDefault,
                             text: apodInfo.explanation ?? "no explanation")
        }
    }

}

extension DetailViewController {

    func configView(imageUrl: String, text: String) {
        self.textView.text = text

        if !imageUrl.isEmpty {
            self.load(url: URL(string: imageUrl))
        }

        self.removeLoader()
    }

    func load(url: URL?) {
        imageView.kf.setImage(with: url)
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
