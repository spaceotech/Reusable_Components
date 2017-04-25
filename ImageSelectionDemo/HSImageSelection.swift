//
//  HSImageSelection.swift
//  ImageSelectionDemo
//
//  Created by Hitendra Mac on 18/03/17.
//  Copyright © 2017 Hitendra Mac. All rights reserved.
//

import UIKit

//This is the completion block used to get image back in calling viewController
typealias HSImageSelectionComplitionBlock = (_ imageSelect:HSImageSelection, _ selectedImage : UIImage?)->()

class HSImageSelection: NSObject {
    
    static let manager = HSImageSelection()
    
    var confirmBlock : HSImageSelectionComplitionBlock?
    fileprivate var openInViewController : UIViewController!
    
    //main function used to show imageSelection options
    func openImagePicker(from viewController:UIViewController, allowEditing : Bool, confirm:@escaping HSImageSelectionComplitionBlock)  {
        confirmBlock = nil
        confirmBlock = confirm
        openInViewController = viewController
        
        //create ActionSheet to show options to user
        let alertController = UIAlertController(title: "Select photo", message: "Select photo", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.selectPictureFrom(UIImagePickerControllerSourceType.camera, allowEditing: allowEditing);
        }
        
        let photoGelleryAction = UIAlertAction(title: "Photo Gallery", style: .default) { action in
            self.selectPictureFrom(UIImagePickerControllerSourceType.photoLibrary, allowEditing: allowEditing);
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoGelleryAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //used to open UIImagePickerController with selected sourceType
    fileprivate func selectPictureFrom(_ sourceType : UIImagePickerControllerSourceType, allowEditing : Bool)
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = allowEditing
        picker.delegate = self
        picker.sourceType = sourceType
        openInViewController.present(picker, animated: true, completion: nil)
    }
    
}

//MARK:- UIImagePickerControllerDelegate
extension HSImageSelection :UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //this method triggers when user select cancel In Photo selection screen
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if confirmBlock != nil{
            confirmBlock!(self,nil)
        }
        openInViewController.dismiss(animated: true, completion: nil)
    }
    
    //this method triggers when user select Photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage? = nil
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        }
        
        //give image back to calling ViewController
        confirmBlock?(self,newImage)
        
        
        openInViewController.dismiss(animated: true, completion: nil)
    }
}
