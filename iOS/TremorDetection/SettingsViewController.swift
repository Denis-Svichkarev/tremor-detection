//
//  SettingsViewController.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var measurementTimeTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measurementTimeTextField.text = "\(MeasurementService.shared.tremorDetectionSDK.getMeasurementTime())"
        
        userIdTextField.addTarget(self, action: #selector(SettingsViewController.textFieldDidChange(_:)), for: .editingChanged)
        measurementTimeTextField.addTarget(self, action: #selector(SettingsViewController.textFieldDidChange(_:)), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Settings"
        
        if MeasurementService.shared.tremorDetectionSDK.getMeasurementTime() >= 0 && MeasurementService.shared.tremorDetectionSDK.getMeasurementTime() <= 120 {
            startButton.isEnabled = true
            startButton.alpha = 1
            
        } else {
            startButton.isEnabled = false
            startButton.alpha = 0.6
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func onStartButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(StoryboardService.shared.getMeasurementViewController(), animated: true)
    }
    
    // MARK: - TextField
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == measurementTimeTextField {
            if let text = textField.text, let time = Int(text) {
                MeasurementService.shared.tremorDetectionSDK.setMeasurementTime(time)
            }
        }

        configureUI()
    }
}
