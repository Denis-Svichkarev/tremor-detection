//
//  CompletedViewController.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 05.12.2020.
//

import UIKit

class CompletedViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    
    var tremorData: Data?
    var tremorDataString: String?
    
    var isUploaded: Bool = false
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tremorData = tremorData, let tremorDataString = tremorDataString {
            FirebaseService.shared.sendData(data: tremorData, fileName:tremorDataString) { success in
                self.isUploaded = true
                self.configureUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Result"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(CompletedViewController.onNextButtonPressed))
        navigationItem.setHidesBackButton(true, animated: false)
        
        if isUploaded {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    // MARK: - IB Actions
    
    @objc func onNextButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
