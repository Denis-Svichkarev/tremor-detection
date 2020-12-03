//
//  MeasurementService.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import UIKit

class MeasurementService: NSObject {

    static let shared = MeasurementService()
    
    let tremorDetectionSDK = DSTremorDetectionSDK()
    
    private override init() {}
}
