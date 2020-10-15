import UIKit

extension UILabel {
    
    convenience init(text: String = "", textColor: UIColor = .label, font: UIFont = .systemFont(ofSize: 16), alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = alignment
        self.numberOfLines = 0
    }
    
    
}
