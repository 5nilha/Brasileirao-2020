//
//  Cache.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class Cache {
    static let images = NSCache<NSString, UIImage>()
    
    class func saveImage(teamId: String, image: UIImage) {
        Cache.images.object(forKey: NSString(string: teamId))
        Cache.images.setObject(image, forKey: NSString(string: "(teamId).png"))
        
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = teamId
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            try data.write(to: fileURL)
            return 
        } catch let error {
            print("error saving file with error", error)
        }
    }

    
    class func getSavedImage(teamId: String) -> UIImage? {
        
        if let image =  Cache.images.object(forKey: NSString(string: teamId)) {
            return image
        }
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(teamId).path)
        }
        return nil
    }
    
}
