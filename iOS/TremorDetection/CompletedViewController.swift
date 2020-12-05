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
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Result"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(CompletedViewController.onNextButtonPressed))
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    // MARK: - IB Actions
    
    @objc func onNextButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
