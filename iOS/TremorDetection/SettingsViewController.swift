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
    @IBOutlet weak var simulationSwitch: UISwitch!
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.text = MeasurementService.shared.userID
        measurementTimeTextField.text = MeasurementService.shared.measurementTime
        
        userIdTextField.addTarget(self, action: #selector(SettingsViewController.textFieldDidChange(_:)), for: .editingChanged)
        measurementTimeTextField.addTarget(self, action: #selector(SettingsViewController.textFieldDidChange(_:)), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Settings"
        
        if let _ = MeasurementService.shared.measurementTime {
            startButton.isEnabled = true
            startButton.alpha = 1
            
        } else {
            startButton.isEnabled = false
            startButton.alpha = 0.6
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func onStartButtonPressed(_ sender: Any) {
        if let measurementTime = MeasurementService.shared.measurementTime, let time = Int(measurementTime) {
            let error = MeasurementService.shared.tremorDetectionSDK.configureMeasurementTime(time)
            
            switch error {
            case .noError:
                navigationController?.pushViewController(StoryboardService.shared.getMeasurementViewController(), animated: true)
            case .invalidTime:
                popupAlert(title: "Invalid time. It should be in the range (20-120 seconds)", message: nil, actionTitles: ["Close"], actions: [{ action in }])
            default: break
            }
        }
    }
    
    // MARK: - TextField
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == measurementTimeTextField {
            if let text = textField.text, let _ = Int(text) {
                MeasurementService.shared.measurementTime = text
            }
        } else if textField == userIdTextField {
            if let text = textField.text, let _ = Int(text) {
                MeasurementService.shared.userID = text
            }
        }

        configureUI()
    }
}