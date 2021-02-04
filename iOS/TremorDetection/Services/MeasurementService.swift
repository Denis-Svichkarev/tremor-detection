//
//  MeasurementService.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class MeasurementService: NSObject {

    static let shared = MeasurementService()
    
    let tremorDetectionSDK = HTDTremorDetectionSDK()
    
    private override init() {}
    
    var userID: String? {
        set { saveUserID(id: newValue) }
        get { return loadUserData() }
    }
    
    var measurementTime: String? {
        set { saveMeasurementTime(time: newValue) }
        get { return loadMeasurementTime() }
    }
    
    // MARK: - UserDefaults
    
    private func saveUserID(id: String?) {
        UserDefaults.standard.set(id, forKey: kUserIDKey)
        UserDefaults.standard.synchronize()
    }
    
    private func loadUserData() -> String? {
        UserDefaults.standard.string(forKey: kUserIDKey)
    }
    
    private func saveMeasurementTime(time: String?) {
        UserDefaults.standard.set(time, forKey: kMeasurementTimeKey)
        UserDefaults.standard.synchronize()
    }
    
    private func loadMeasurementTime() -> String? {
        UserDefaults.standard.string(forKey: kMeasurementTimeKey)
    }
}
