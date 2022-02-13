//
//  LoaderView.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import UIKit

class LoaderView: UIView {

    var activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        activityIndicator.color = .black
        self.addSubview(activityIndicator)
    }
}

extension UIViewController {
    
    func showLoader() {
        
        let loaderView = LoaderView.init(frame: view.bounds)
        loaderView.backgroundColor = .white
        
        DispatchQueue.main.async {
            self.view.addSubview(loaderView)
        }
    }
    
    func removeLoader() {
        
        if let loaderView = self.view.subviews.last, loaderView.isKind(of: LoaderView.self) {
            
            DispatchQueue.main.async {
                loaderView.removeFromSuperview()
            }
        }
    }
}
