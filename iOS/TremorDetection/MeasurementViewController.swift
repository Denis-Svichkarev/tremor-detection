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
        
        MeasurementService.shared.tremorDetectionSDK.configure(withDelegate: self, measurementTime: 10)
        MeasurementService.shared.tremorDetectionSDK.startMeasurement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        MeasurementService.shared.tremorDetectionSDK.stopMeasurement()
    }
    
    func configureUI() {
        navigationItem.title = "Measurement"
    }
}

extension MeasurementViewController: DSTremorDetectionDelegate {
    func onProgressUpdated(_ percentCompleted: Int) {
        
    }
    
    func onMeasurementCompleted(_ tremorResult: DSTremorResult, accuracy: CGFloat) {
        
    }
}
