//
//  HSimageSelection.swift
//  ImageSelectionDemo
//
//  Created by SOTSYS008 on 12/03/19.
//  Copyright © 2019 SOTSYS008. All rights reserved.
//

import UIKit

 typealias HSImageSelectionComplitionBlock = (_ imageSelect:HSImageSelection, _ selectedImage : UIImage?)->()
    
    class HSImageSelection: NSObject {
        
        static let manager = HSImageSelection()
        
        var confirmBlock : HSImageSelectionComplitionBlock?
        fileprivate var openInViewController : UIViewController!
        func openImagePicker(from viewController:UIViewController, allowEditing : Bool, confirm:@escaping HSImageSelectionComplitionBlock)  {
            confirmBlock = nil
            confirmBlock = confirm
            openInViewController = viewController
            
            //create ActionSheet to show options to user
            let alertController = UIAlertController(title: "Select photo", message: "Select photo", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                
            }
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.selectPictureFrom(UIImagePickerController.SourceType.camera, allowEditing: allowEditing);
                }else{
                    print("You don't have a camera for this device")
                    
                }
            }
           
            let photoGelleryAction = UIAlertAction(title: "Photo Gallery", style: .default) { action in
                self.selectPictureFrom(UIImagePickerController.SourceType.photoLibrary, allowEditing: allowEditing);
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(cameraAction)
            alertController.addAction(photoGelleryAction)
            
            viewController.present(alertController, animated: true, completion: nil)
        }
        
        //used to open UIImagePickerController with selected sourceType
        fileprivate func selectPictureFrom(_ sourceType : UIImagePickerController.SourceType, allowEditing : Bool)
        {
            let picker = UIImagePickerController()
            picker.allowsEditing = allowEditing
            picker.sourceType = sourceType
            picker.delegate = self
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
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    //this method triggers when user select Photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
     {
        var newImage: UIImage? = nil
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
       
        {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        //give image back to calling ViewController
        confirmBlock?(self,newImage)
        
        
        openInViewController.dismiss(animated: true, completion: nil)
    }
}




