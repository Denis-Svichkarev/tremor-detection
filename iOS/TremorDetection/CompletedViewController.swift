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
    
    var accelerometerData: Data?
    var accelerometerDataString: String?
    
    var audioData: Data?
    var audioDataString: String?
    
    var cameraData: Data?
    var cameraDataString: String?
    
    var isUploaded: Bool = false
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadAccelerometerData()
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
    
    // MARK: - Uploading
    
    func uploadAccelerometerData() {
        if isAccelerometerUploadingEnabled {
            if let accelerometerData = accelerometerData, let accelerometerDataString = accelerometerDataString {
                FirebaseService.shared.sendData(data: accelerometerData, fileName:accelerometerDataString) { success in
                    self.uploadAudioData()
                }
            }
        } else {
            self.uploadAudioData()
        }
    }
    
    func uploadAudioData() {
        if isAudioUploadingEnabled {
            if let audioData = audioData, let audioDataString = audioDataString {
                FirebaseService.shared.sendData(data: audioData, fileName:audioDataString) { success in
                    self.uploadCameraData()
                }
            }
        } else {
            self.uploadCameraData()
        }
    }
    
    func uploadCameraData() {
        if isVideoUploadingEnabled {
            if let cameraData = cameraData, let cameraDataString = cameraDataString {
                FirebaseService.shared.sendData(data: cameraData, fileName:cameraDataString) { success in
                    self.isUploaded = true
                    self.configureUI()
                }
            }
        } else {
            self.isUploaded = true
            self.configureUI()
        }
    }
    
    // MARK: - IB Actions
    
    @objc func onNextButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
