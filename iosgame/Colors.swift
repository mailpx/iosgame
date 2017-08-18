
import Foundation
import UIKit

class Colors {
    
    var colors: [Color]
    
    init() {
        colors = [Color]()
        
        colors.append(Color(color: UIColor.cyan, colorName: "cyan"))
        colors.append(Color(color: UIColor.magenta, colorName: "magenta"))
        colors.append(Color(color: UIColor.red, colorName: "red"))
        colors.append(Color(color: UIColor.green, colorName: "green"))
        colors.append(Color(color: UIColor.blue, colorName: "blue"))
    }
    
    class Color {
        let color: UIColor
        let colorName: String
        
        init(color: UIColor, colorName: String) {
            self.color = color
            self.colorName = colorName
        }
    }
    
}


