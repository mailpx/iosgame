
import Foundation
import UIKit

class Colors {
    
    var colors: [Color]
    
    init() {
        colors = [Color]()
        
        colors.append(Color(color: UIImage.from(color: UIColor.cyan), colorName: "cyan"))
        colors.append(Color(color: UIImage.from(color: UIColor.magenta), colorName: "magenta"))
        colors.append(Color(color: UIImage.from(color: UIColor.red), colorName: "red"))
        colors.append(Color(color: UIImage.from(color: UIColor.green), colorName: "green"))
        colors.append(Color(color: UIImage.from(color: UIColor.blue), colorName: "blue"))
        colors.append(Color(color: UIImage(named: "game.scnassets/Colors/a1.png")!, colorName: "a1"))
        colors.append(Color(color: UIImage(named: "game.scnassets/Colors/g1.png")!, colorName: "g1"))
        colors.append(Color(color: UIImage(named: "game.scnassets/Colors/g2.png")!, colorName: "g2"))
        colors.append(Color(color: UIImage(named: "game.scnassets/Colors/w1.png")!, colorName: "w1"))
        colors.append(Color(color: UIImage(named: "game.scnassets/Colors/w2.png")!, colorName: "w2"))
    }
    
    func getColors(colorName: String) -> UIImage {
        
        for i in 0...colors.count {
            if colors[i].colorName == colorName {
                return colors[i].color
            }
        }
        
        return UIImage.from(color: UIColor.cyan)
    }
    
    func getColorIndex(colorName: String) -> Int {
        
        for i in 0...colors.count {
            
            if colors[i].colorName == colorName {
                return i
            }
        }
        
        return 0
    }
    
    class Color {
        let color: UIImage
        let colorName: String
        
        init(color: UIImage, colorName: String) {
            self.color = color
            self.colorName = colorName
        }
    }
    
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
