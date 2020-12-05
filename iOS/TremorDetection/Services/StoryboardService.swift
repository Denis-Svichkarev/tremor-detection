//
//  StoryboardService.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class StoryboardService: NSObject {

    static let shared = StoryboardService()
    
    private override init() {}
    
    func getSettingsViewController() -> SettingsViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    }
    
    func getMeasurementViewController() -> MeasurementViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeasurementViewController") as! MeasurementViewController
    }
    
    func getCompletedViewController() -> CompletedViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompletedViewController") as! CompletedViewController
    }
}
