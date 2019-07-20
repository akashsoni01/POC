//
//  ViewController.swift
//  ImagePicker in swfit 4.2
//
//  Created by Akash Soni on 21/07/19.
//  Copyright © 2019 Akash Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.allowsEditing = true
        imagePickerView.sourceType = .camera
        self.present(imagePickerView, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel tapped")
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

