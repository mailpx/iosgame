
import Foundation
import UIKit

class DataManager {
    
    let preferences: UserDefaults!
    let colors: Colors!
    
    init() {
        preferences = UserDefaults.standard
        colors = Colors()
    }
    
    func getPoints() -> Int {
        if preferences.object(forKey: "points") == nil {
            preferences.set(0, forKey: "points")
            preferences.synchronize()
            
            return 0
        } else {
            return preferences.integer(forKey: "points")
        }
    }
    
    func addPoints(points: Int) {
        var numPoints = 0
        if preferences.object(forKey: "points") == nil {
            numPoints = 0
        } else {
            numPoints = preferences.integer(forKey: "points")
        }
        
        numPoints += points
        
        preferences.set(numPoints, forKey: "points")
        preferences.synchronize()
    }
    
    func buyColor(colorName: String) {
        var colorsName: String
        if preferences.object(forKey: "Colors") == nil {
            colorsName = ""
        } else {
            colorsName = preferences.string(forKey: "Colors")!
        }
        
        if colorsName.range(of: colorName) == nil {
            colorsName += colorName + ","
            preferences.set(colorsName, forKey: "Colors")
            
            preferences.synchronize()
        }
        
    }
    
    func isColorBought(colorName: String) -> Bool {
        var colorsName: String
        if preferences.object(forKey: "Colors") == nil {
            return false
        } else {
            colorsName = preferences.string(forKey: "Colors")!
        }
        
        if colorsName.range(of: colorName) == nil {
            return false
        }
        
        return true
    }
    
    func getSettedColor() -> String {
        if preferences.object(forKey: "colorSet") == nil {
            return colors.colors[0].colorName
        } else {
            let colorName = preferences.string(forKey: "colorSet")!
            return colorName
        }
    }
    
    func getColor() -> UIImage {
        if preferences.object(forKey: "colorSet") == nil {
            return UIImage.from(color: UIColor.cyan)
        } else {
            let colorName = preferences.string(forKey: "colorSet")!
            return colors.getColors(colorName: colorName)
        }
    }
    
    func setColor(colorName: String) {
        preferences.set(colorName, forKey: "colorSet")
        
        preferences.synchronize()
    }

}
