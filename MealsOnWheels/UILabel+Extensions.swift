import UIKit

extension UILabel {
    convenience init(fontName: String, size: CGFloat, color: UIColor = UIColor.white) {
        self.init()
        self.font = UIFont(name: fontName, size: size)
        self.textColor = color
    }
    
    convenience init(font: UIFont?, color: UIColor = UIColor.white) {
        self.init()
        self.font = font
        self.textColor = color
    }
    
    func setUnderline() -> String{
        
        var num: Float = 0.0
        var underlines: Float = 0.0
        var finalS = ""
        var rounded = 0
        
        num = Float(MWConstants.screenWidth) - Float(MWConstants.loginFieldsOffset*2)
        underlines = round(num / 8)
        rounded = Int(underlines)
        
        for _ in (0)...rounded{
            finalS += "_"
        }
        finalS += "_"
        return finalS
    }

}
