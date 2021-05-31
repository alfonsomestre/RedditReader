//
//  ImageSaver.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    
    let callbackFunc: ((_ success: Bool) -> Void)
    
    init(callbackFunc: @escaping (Bool) -> Void ) {
        self.callbackFunc = callbackFunc
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        self.callbackFunc(error == nil)
    }
}
