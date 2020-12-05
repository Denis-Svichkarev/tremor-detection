//
//  UIViewControllerExtensions.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

var loadingSpinnerView: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        loadingSpinnerView = spinnerView
    }
    
    func showSpinner(onView: UIView, labelText: String) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        let labelWidth: CGFloat = 160
        let labelHeight: CGFloat = 30
        let verticalSpace: CGFloat = 60
        
        let label = UILabel(frame: CGRect(x: spinnerView.center.x - (labelWidth / 2), y: spinnerView.center.y - verticalSpace, width: labelWidth, height: labelHeight))
        label.text = labelText
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            spinnerView.addSubview(label)
            onView.addSubview(spinnerView)
        }
        
        loadingSpinnerView = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            loadingSpinnerView?.removeFromSuperview()
            loadingSpinnerView = nil
        }
    }
}

extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    class func topController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
