
//  CameraAlertController.swift
//  ShoppingList
//
//  Created by vitor.ferrazvarela on 06/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit
protocol CameraAlertControllerDelegate: AnyObject {
    func presentFromAlert(_ viewController: UIViewController) 
    func didSelectedImage(_ image: UIImage)
}
class CameraAlertController: NSObject {
    weak var delegate: CameraAlertControllerDelegate?
    var alert: UIAlertController {
        let alertController = UIAlertController(title: "Selecionar poster", message: "De onde você quer escolher o poster", preferredStyle: .actionSheet)
        setupOptions(on: alertController)
        return alertController
        
    }
   
    private func setupOptions(on alert: UIAlertController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            })
            alert.addAction(camera)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let gallery = UIAlertAction(title: "Galeria", style: .default, handler: { _ in
                self.openGallery()
            })
            alert.addAction(gallery)
        }
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.delegate?.presentFromAlert(imagePicker)
        }
        else {
            let alert  = UIAlertController(title: "Ops", message: "Você não tem acesso a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.delegate?.presentFromAlert(alert)
        }
    }
    
     func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.delegate?.presentFromAlert(imagePicker)
        }
            
        else {
            let alert  = UIAlertController(title: "Ops", message: "Você não tem acesso a galeria.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.delegate?.presentFromAlert(alert)
        }
    }
}

extension CameraAlertController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.delegate?.didSelectedImage(pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
