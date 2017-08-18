
import Foundation
import SpriteKit

class GameButtonNode : SKShapeNode {
    
    var textNode: SKLabelNode!
    var callback:(() -> ())? = nil
    
    override init() {
        super.init()
    }
    
    convenience init(size: CGSize, text: String, fontSize: CGFloat, callback:@escaping (() -> ())) {
        self.init()
        
        textNode = SKLabelNode(text: text)
        textNode.fontSize = fontSize
        textNode.fontName = "HelveticaNeue"
        
        self.init(rectOf: CGSize(width: textNode.frame.width+20, height: textNode.frame.height + 20), cornerRadius: 3)
        self.isUserInteractionEnabled = true
        
        textNode = SKLabelNode(text: text)
        textNode.fontSize = fontSize
        textNode.fontName = "HelveticaNeue"
        textNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY - textNode.frame.height/2)
        setColor()
        
        self.addChild(self.textNode)
        
        self.callback = callback
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.strokeColor = UIColor.white
        self.fillColor = UIColor.init(red: 0.95, green: 0.7, blue: 0.74, alpha: 1)
        textNode.fontColor = UIColor.cyan
    }
    
    func setColor() {
        self.strokeColor = UIColor.white
        self.fillColor = UIColor.init(red: 1, green: 0.75, blue: 0.79, alpha: 1)
        textNode.fontColor = UIColor.white
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setColor()
        if(self.callback != nil){
            self.callback!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
