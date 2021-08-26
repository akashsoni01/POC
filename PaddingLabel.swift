import Foundation
import UIKit

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    var closure: () -> Void = {
         /// empty initialization
     }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
//        self.addTapGesture(target: self, #selector(labelTapped))
    }
    
    func labelTapped(_ complition:@escaping () -> Void){
        closure = complition
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    @objc func labelTapped() {
        // Your Code.
       DispatchQueue.main.async { [weak self] in
           self?.closure()
       }
    }
}
