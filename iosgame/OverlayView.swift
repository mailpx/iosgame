
import Foundation
import SpriteKit

class OverlayView : SKScene {
    
    var pauseNode: PauseButtonNode!
    var menu: SKShapeNode!
    var continueButton: GameButtonNode!
    var returnButton: GameButtonNode!
    
    var start = true
    var pause = false
    
    init(size: CGSize, game: UIViewController) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.clear
        
        let spriteSize : CGFloat
        if (size.height > size.width){
            spriteSize = size.width/8
        }else{
            spriteSize = size.height/8
            start = false
        }
        self.pauseNode = PauseButtonNode(spriteSize: spriteSize, callback: {(pause: Bool) in
                self.pause = pause
                self.menu.isHidden = !pause
        })
        self.pauseNode.position = CGPoint(x: spriteSize + 8, y: spriteSize + 8)
        self.addChild(self.pauseNode)
        
        let smenuSize : CGSize
        if (size.height > size.width){
            smenuSize = CGSize(width: size.width*0.7, height: size.height*0.4)
        }else{
            smenuSize = CGSize(width: size.width*0.5, height: size.height*0.6)
        }
        menu = SKShapeNode(rectOf: smenuSize)
        menu.fillColor = UIColor.white
        menu.fillTexture = SKTexture.init(image: UIImage(named: "game.scnassets/Textures/gp.png")!)
        menu.strokeColor = UIColor.clear
        menu.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(menu)
        
        let fontSize : CGFloat
        if (size.height > size.width){
            fontSize = size.width/20
        }else{
            fontSize = size.height/20
        }
        
        continueButton = GameButtonNode(size: size, text: "ｃｏｎｔｉｎｕｅ", fontSize: fontSize, callback: {() in
            self.pause = !self.pause
            self.pauseNode.start()
            self.menu.isHidden = true
        })
        continueButton.position = CGPoint(x: 0, y: continueButton.frame.height)
        menu.addChild(continueButton)
        
        returnButton = GameButtonNode(size: size, text: "ｒｅｔｕｒｎ", fontSize: fontSize, callback: {() in
            game.dismiss(animated: true, completion: nil)
        })
        returnButton.position = CGPoint(x: 0, y: -continueButton.frame.height)
        menu.addChild(returnButton)
        
        menu.isHidden = true
        
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = false
        
    }
    
    func won(text: String, point: Int) {
        continueButton.removeFromParent()
        pauseNode.removeFromParent()
        
        let scoreNode = SKLabelNode(text: "ｙｏｕ ｇａｉｎｅｄ " + String(point) + " ｐｏｉｎｔｓ")
        scoreNode.fontName = "HelveticaNeue"
        let scoreScalingFactor = min(menu.frame.width / (scoreNode.frame.width), menu.frame.height / scoreNode.frame.height)
        scoreNode.fontSize *= scoreScalingFactor
        scoreNode.position = CGPoint(x: 0, y: scoreNode.frame.height / 2.0)
        menu.addChild(scoreNode)
        
        let textNode = SKLabelNode(text: text)
        textNode.fontName = "HelveticaNeue"
        let scalingFactor = min(menu.frame.width / (1.2 * textNode.frame.width), menu.frame.height / textNode.frame.height)
        textNode.fontSize *= scalingFactor
        textNode.position = CGPoint(x: 0, y: 2 * scoreNode.frame.height + textNode.frame.height / 2)
        menu.addChild(textNode)
        
        pause = true
        
        menu.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func transitionChange(size: CGSize) {
        menu.position = CGPoint(x: size.width/2, y: size.height/2)
    }
    
    
}
