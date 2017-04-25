//
//  ViewController.swift
//  ImageSelectionDemo
//
//  Created by Hitendra Mac on 18/03/17.
//  Copyright © 2017 Hitendra Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!

    @IBAction func btnSelectImageDidTap(_ sender: UIButton) {
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

