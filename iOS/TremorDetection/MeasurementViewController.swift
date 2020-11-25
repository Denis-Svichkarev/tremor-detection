//
//  MeasurementViewController.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class MeasurementViewController: UIViewController {

    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Measurement"
    }
}
