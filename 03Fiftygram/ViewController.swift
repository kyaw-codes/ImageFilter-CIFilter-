//
//  ViewController.swift
//  03Fiftygram
//
//  Created by Ko Kyaw on 06/07/2020.
//  Copyright © 2020 Ko Kyaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = CIContext()
    var originalImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            navigationController?.dismiss(animated: true, completion: nil)
            imageView.image = image
            originalImage = image
        }
    }

    @IBAction func applySepia() {
        guard let original = originalImage else { return }
        
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter, image: original)
    }
    
    @IBAction func applyNoir() {
        guard let original = originalImage else { return }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter, image: original)
    }
    
    @IBAction func applyVintage() {
        guard let original = originalImage else { return }
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter, image: original)
    }
    
    func display(filter: CIFilter?, image: UIImage) {
        filter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: context.createCGImage(output!, from: output!.extent)!)
    }
    
}

