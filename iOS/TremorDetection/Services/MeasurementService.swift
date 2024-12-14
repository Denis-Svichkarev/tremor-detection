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
    
    var exerciseNumber: String? {
        set { saveExerciseNumber(number: newValue) }
        get { return loadExerciseNumber() }
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
    
    private func saveExerciseNumber(number: String?) {
        UserDefaults.standard.set(number, forKey: kExerciseNumberKey)
        UserDefaults.standard.synchronize()
    }
    
    private func loadExerciseNumber() -> String? {
        UserDefaults.standard.string(forKey: kExerciseNumberKey)
    }
}
