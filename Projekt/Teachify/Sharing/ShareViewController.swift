//
//  ShareViewController.swift
//  Sharing
//
//  Created by Bastian Kusserow on 18.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: UIViewController {

    
    @IBOutlet var qrImage: UIImageView!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet var overlayView: UIView!
    
    
    @IBAction func dismissQRCodeView(_ sender: UITapGestureRecognizer) {
        print("Gesture recognized")
       
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { (success) in
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.addGestureRecognizer(gestureRecognizer)
        
        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                print("Provider: \(provider)")
                
                if provider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.qrImage
                    provider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { (imageURL, error) in
                        OperationQueue.main.addOperation {
                            
                            if let strongImageView = weakImageView {
                                if let imageURL = imageURL as? URL {
                                    
                                    strongImageView.image = self.createQRCode(string:imageURL.absoluteString)
                                    
                                }
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
                
                
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }
        
        func createQRCode(string: String) -> UIImage? {
            let data = string.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            
            if let ciImage = filter?.outputImage {
                let highResolutionCIImageQR = ciImage.transformed(by: CGAffineTransform(scaleX: 5, y: 5))
                return UIImage(ciImage: highResolutionCIImageQR)
            }
            return nil
        }

}
