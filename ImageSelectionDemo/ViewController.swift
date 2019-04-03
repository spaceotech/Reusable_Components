//
//  ViewController.swift
//  ImageSelectionDemo
//
//  Created by SOTSYS008 on 12/03/19.
//  Copyright © 2019 SOTSYS008. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnSelectImage(_ sender: UIButton) {
        //Call method for open picker options from HSImageSelection
        HSImageSelection.manager.openImagePicker(from: self, allowEditing: true) { (imageSelectionManager, selectedImage) in
            if let image = selectedImage {
                self.imageView.image = image;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

