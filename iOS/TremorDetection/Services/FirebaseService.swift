//
//  FirebaseService.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 13.12.2020.
//

import UIKit
import Firebase
import FirebaseStorage

class FirebaseService: NSObject {

    static let shared = FirebaseService()

    var timeoutTask: DispatchWorkItem?
    var uploadTask: StorageUploadTask?
    
    private override init() {}
    
    func sendData(data: Data, fileName: String, completion: ((_ success: Bool) -> Void)?) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()

        var folder = ""
        
        if MeasurementService.shared.tremorDetectionSDK.getMode() == .normal {
            folder = "/iOS/Movement/"
        } else if MeasurementService.shared.tremorDetectionSDK.getMode() == .simulation {
            folder = "/iOS/Simulation/"
        }
        
        let csvRef = storageRef.child(folder + fileName)
        let metadata = StorageMetadata()
        metadata.contentType = "text/csv";

        var timeoutTask: DispatchWorkItem?

        timeoutTask = DispatchWorkItem{ [weak self] in
            self?.uploadTask?.cancel()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 60, execute: timeoutTask!)

        uploadTask = csvRef.putData(data, metadata: metadata) { metadata, error in
            self.timeoutTask?.cancel()
            self.timeoutTask = nil
            
            if let error = error {
                print("Sending to FireBase: error" + error.localizedDescription)
                if let completion = completion {
                    completion(false)
                }
            
            } else {
                print("Sending to FireBase: success")
                if let completion = completion {
                    completion(true)
                }
            }
        }
        
        uploadTask?.observe(StorageTaskStatus.success) { snapshot in }
        uploadTask?.observe(StorageTaskStatus.failure) { snapshot in }
        uploadTask?.observe(StorageTaskStatus.progress) { snapshot in }
    }
}
