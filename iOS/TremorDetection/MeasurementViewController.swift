//
//  MeasurementViewController.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class MeasurementViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var axisXImageView: UIImageView!
    @IBOutlet weak var axisYImageView: UIImageView!
    @IBOutlet weak var axisZImageView: UIImageView!
    
    @IBOutlet weak var axisXStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var axisYStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var axisZStackWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var axisXScrollView: UIScrollView!
    @IBOutlet weak var axisYScrollView: UIScrollView!
    @IBOutlet weak var axisZScrollView: UIScrollView!
    
    var axisXOffest: Float = 0
    var axisYOffest: Float = 0
    var axisZOffest: Float = 0
    
    var isSimulationMode = false
    
    // MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isSimulationMode {
            MeasurementService.shared.tremorDetectionSDK.configureMode(.simulation)
        } else {
            MeasurementService.shared.tremorDetectionSDK.configureMode(.normal)
        }
        
        if let userID = MeasurementService.shared.userID {
            MeasurementService.shared.tremorDetectionSDK.configureUserID(userID)
        }
        
        MeasurementService.shared.tremorDetectionSDK.configure(withDelegate: self)
        MeasurementService.shared.tremorDetectionSDK.configureAxisXGraph(axisXImageView.bounds)
        MeasurementService.shared.tremorDetectionSDK.configureAxisYGraph(axisYImageView.bounds)
        MeasurementService.shared.tremorDetectionSDK.configureAxisZGraph(axisZImageView.bounds)
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
    
    // MARK: - Helpers
    
    func getStatusString(status: DSTremorStatus) -> String {
        switch status {
        case .started: return "Started"
        case .stopped: return "Stopped"
        @unknown default: fatalError()
        }
    }
    
    func getWarningString(warning: DSTremorWarning) -> String {
        switch warning {
        case .noWarning: return "No warning"
        case .movementDetected: return "Movement detected"
        case .tremorDetected: return "Tremor detected"
        @unknown default: fatalError()
        }
    }
}

extension MeasurementViewController: DSTremorDetectionDelegate {
    
    func onProgressUpdated(_ percentCompleted: Int) {
        progressLabel.text = "\(percentCompleted) %"
    }
    
    func onMeasurementCompleted(_ tremorResult: DSTremorResult, confidence: CGFloat) {
        let vc = StoryboardService.shared.getCompletedViewController()
        vc.tremorData = MeasurementService.shared.tremorDetectionSDK.exportData()
        vc.tremorDataString = MeasurementService.shared.tremorDetectionSDK.exportFileName()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onStatusReceived(_ status: DSTremorStatus) {
        statusLabel.text = "Status: \(getStatusString(status: status))"
    }
    
    func onWarningReceived(_ warning: DSTremorWarning) {
        warningLabel.text = "Warning: \(getWarningString(warning: warning))"
    }
    
    func onAxisXOffsetGraphImageUpdated(_ image: UIImage!) {
        axisXOffest = Float(image.size.width - axisXStackWidthConstraint.constant)
        axisXStackWidthConstraint.constant = image.size.width
        axisXImageView.image = image
        
        if axisXScrollView.contentOffset.x + axisXScrollView.frame.size.width == axisXScrollView.contentSize.width || axisXScrollView.contentSize.width < axisXScrollView.frame.size.width {
            axisXScrollView.setContentOffset(CGPoint(x: image.size.width, y: 0), animated: false)
        }
    }
    
    func onAxisYOffsetGraphImageUpdated(_ image: UIImage!) {
        axisYOffest = Float(image.size.width - axisYStackWidthConstraint.constant)
        axisYStackWidthConstraint.constant = image.size.width
        axisYImageView.image = image
        
        if axisYScrollView.contentOffset.x + axisYScrollView.frame.size.width == axisYScrollView.contentSize.width || axisYScrollView.contentSize.width < axisYScrollView.frame.size.width {
            axisYScrollView.setContentOffset(CGPoint(x: image.size.width, y: 0), animated: false)
        }
    }
    
    func onAxisZOffsetGraphImageUpdated(_ image: UIImage!) {
        axisZOffest = Float(image.size.width - axisZStackWidthConstraint.constant)
        axisZStackWidthConstraint.constant = image.size.width
        axisZImageView.image = image
        
        if axisZScrollView.contentOffset.x + axisZScrollView.frame.size.width == axisZScrollView.contentSize.width || axisZScrollView.contentSize.width < axisZScrollView.frame.size.width {
            axisZScrollView.setContentOffset(CGPoint(x: image.size.width, y: 0), animated: false)
        }
    }
}
