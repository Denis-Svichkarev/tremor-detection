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
    
    @IBOutlet weak var axisXImageView: UIImageView!
    @IBOutlet weak var axisYImageView: UIImageView!
    @IBOutlet weak var axisZImageView: UIImageView!
    
    @IBOutlet weak var axisXStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var axisYStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var axisZStackWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var axisXScrollView: UIScrollView!
    @IBOutlet weak var axisYScrollView: UIScrollView!
    @IBOutlet weak var axisZScrollView: UIScrollView!
    
    @IBOutlet weak var tremorProbabilityLabel: UILabel!
    @IBOutlet weak var movementProbabilityLabel: UILabel!
    @IBOutlet weak var motionlessProbabilityLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var abortButton: UIButton!
    
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
        MeasurementService.shared.tremorDetectionSDK.configureAxisXGraph(axisXImageView.bounds, lineColor: .red, backgroundColor: .clear)
        MeasurementService.shared.tremorDetectionSDK.configureAxisYGraph(axisYImageView.bounds, lineColor: .systemGreen, backgroundColor: .clear)
        MeasurementService.shared.tremorDetectionSDK.configureAxisZGraph(axisZImageView.bounds, lineColor: .blue, backgroundColor: .clear)
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
        
        axisXScrollView.layer.borderWidth = 1
        axisXScrollView.layer.borderColor = UIColor.black.cgColor
        axisXScrollView.layer.backgroundColor = UIColor.magenta.withAlphaComponent(0.2).cgColor
        
        axisYScrollView.layer.borderWidth = 1
        axisYScrollView.layer.borderColor = UIColor.black.cgColor
        axisYScrollView.layer.backgroundColor = UIColor.magenta.withAlphaComponent(0.2).cgColor
        
        axisZScrollView.layer.borderWidth = 1
        axisZScrollView.layer.borderColor = UIColor.black.cgColor
        axisZScrollView.layer.backgroundColor = UIColor.magenta.withAlphaComponent(0.2).cgColor
        
        abortButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
    }
    
    // MARK: - IB Actions
    
    @IBAction func onStopButtonPressed(_ sender: Any) {
        MeasurementService.shared.tremorDetectionSDK.stopMeasurement()
    }
    
    @IBAction func onAbortButtonPressed(_ sender: Any) {
        MeasurementService.shared.tremorDetectionSDK.abortMeasurement()
    }
    
    // MARK: - Helpers
    
    func getStatusString(status: HTDTremorStatus) -> String {
        switch status {
        case .started: return "Started"
        case .stopped: return "Stopped"
        case .aborted: return "Aborted"
        @unknown default: fatalError()
        }
    }
    
    func getWarningString(warning: HTDTremorWarning) -> String {
        switch warning {
        case .noWarning: return "No warning"
        case .movementDetected: return "Movement detected"
        case .tremorDetected: return "Tremor detected"
        @unknown default: fatalError()
        }
    }
}

extension MeasurementViewController: HTDTremorDetectionDelegate {
    
    func onProgressUpdated(_ percentCompleted: Int) {
        progressLabel.text = "\(percentCompleted) %"
    }
    
    func onMeasurementCompleted(_ tremorResult: HTDTremorResult, confidence: CGFloat) {
        let vc = StoryboardService.shared.getCompletedViewController()
        vc.tremorData = MeasurementService.shared.tremorDetectionSDK.exportData()
        vc.tremorDataString = MeasurementService.shared.tremorDetectionSDK.exportFileNameAudio(false)
        vc.tremorAudioData = MeasurementService.shared.tremorDetectionSDK.recordedAudio()
        vc.tremorAudioDataString = MeasurementService.shared.tremorDetectionSDK.exportFileNameAudio(true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onStatusReceived(_ status: HTDTremorStatus) {
        if status == .aborted {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func onWarningReceived(_ warning: HTDTremorWarning) {
        if warning == .tremorDetected {
            statusLabel.textColor = .red
        } else if warning == .movementDetected {
            statusLabel.textColor = .orange
        } else if warning == .noWarning {
            statusLabel.textColor = .black
        }
        
        statusLabel.text = "Status: \(getWarningString(warning: warning))"
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
    
    func onClassificationResultUpdated(_ result: HTDClassificationResult!) {
        let tremorStr = String(format: "%.f", result.tremorProbability * 100)
        let movementStr = String(format: "%.f", result.movementProbability * 100)
        let motionlessStr = String(format: "%.f", result.motionlessProbability * 100)
        
        tremorProbabilityLabel.text = "Tremor probability: \(tremorStr)%"
        movementProbabilityLabel.text = "Movement probability: \(movementStr)%"
        motionlessProbabilityLabel.text = "Motionless probability: \(motionlessStr)%"
    }
}
