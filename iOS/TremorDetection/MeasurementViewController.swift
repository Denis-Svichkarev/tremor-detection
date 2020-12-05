//
//  MeasurementViewController.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class MeasurementViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MeasurementService.shared.tremorDetectionSDK.configure(withDelegate: self)
        MeasurementService.shared.tremorDetectionSDK.startMeasurement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureUI() {
        navigationItem.title = "Measurement"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    // MARK: - IB Actions
    
    @IBAction func onStopButtonPressed(_ sender: Any) {
        MeasurementService.shared.tremorDetectionSDK.stopMeasurement()
    }
}

extension MeasurementViewController: DSTremorDetectionDelegate {
    func onProgressUpdated(_ percentCompleted: Int) {
        progressLabel.text = "\(percentCompleted) %"
    }
    
    func onMeasurementCompleted(_ tremorResult: DSTremorResult, confidence: CGFloat) {
        navigationController?.pushViewController(StoryboardService.shared.getCompletedViewController(), animated: true)
    }
    
    func onStatusReceived(_ status: DSTremorStatus) {
        
    }
    
    func onWarningReceived(_ warning: DSTremorWarning) {
        
    }
}
