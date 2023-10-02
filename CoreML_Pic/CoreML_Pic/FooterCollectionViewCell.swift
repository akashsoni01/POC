//
//  FooterCollectionViewCell.swift
//  CoreML_Pic
//
//  Created by Akash soni on 02/10/23.
//

import UIKit

class FooterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIButton!
    
    @IBAction func didEndOnExit(_ sender: UIButton) {
        debugPrint("didEndOnExit \(sender.tag)")
        
    }
    
    @IBAction func editingChanged(_ sender: UIButton) {
        debugPrint("editingChanged \(sender.tag)")

    }
    
    @IBAction func editingDidBegin(_ sender: UIButton) {
        debugPrint("editingDidBegin \(sender.tag)")

    }
    
    @IBAction func editingDidEnd(
        _ sender: UIButton) {
            debugPrint("editingDidEnd \(sender.tag)")

    }
    
    @IBAction func primaryActionTriggered(_ sender: UIButton) {
        debugPrint("primaryActionTriggered \(sender.tag)")

    }
    
    @IBAction func touchCancel(_ sender: UIButton) {
        debugPrint("touchCancel \(sender.tag)")

    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        debugPrint("touchDown \(sender.tag)")

    }
    
    @IBAction func touchDownRepeat(_ sender: UIButton) {
        debugPrint("touchDownRepeat \(sender.tag)")

    }
    
    @IBAction func touchDragEnter(_ sender: UIButton) {
        debugPrint("touchDragEnter \(sender.tag)")

    }
    
    @IBAction func touchDragExit(_ sender: UIButton) {
        debugPrint("touchDragExit \(sender.tag)")

    }
    
    @IBAction func touchDragInside(_ sender: UIButton) {
        debugPrint("touchDragInside \(sender.tag)")

    }
    
    @IBAction func touchDragOutside(_ sender: UIButton) {
        debugPrint("touchDragOutside \(sender.tag)")

    }
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        debugPrint("touchUpInside \(sender.tag)")

    }
    
    @IBAction func touchUpOutside(_ sender: UIButton) {
        debugPrint("touchUpOutside \(sender.tag)")

    }
    
    @IBAction func valueChanged(_ sender: UIButton) {
        debugPrint("valueChanged \(sender.tag)")

    }
    
    
}
