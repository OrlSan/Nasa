//
//  ViewExtensio.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/26/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import UIKit

var localView : UIView?

extension UIViewController {
    func showLoader(onView : UIView) {
        let loaderView = UIView.init(frame: onView.bounds)
        loaderView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.startAnimating()
        indicator.center = loaderView.center
        
        DispatchQueue.main.async {
            loaderView.addSubview(indicator)
            onView.addSubview(loaderView)
        }
        
        localView = loaderView
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            localView?.removeFromSuperview()
            localView = nil
        }
    }
}
