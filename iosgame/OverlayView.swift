
import Foundation
import SpriteKit

class OverlayView : SKScene {
    
    var pauseNode: PauseButtonNode!
    var scoreNode: SKLabelNode!
    var menu: SKShapeNode!
    var confirm: SKShapeNode!
    var continueButton: GameButtonNode!
    var returnButton: GameButtonNode!
    var readyLabel: SKLabelNode!
    
    var pause = false
    var stop = false
    
    init(size: CGSize, game: UIViewController) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.clear
        
        let spriteSize : CGFloat
        if (size.height > size.width){
            spriteSize = size.width/8
        }else{
            spriteSize = size.height/8
        }
        self.pauseNode = PauseButtonNode(spriteSize: spriteSize, callback: {(pause: Bool) in
                self.pause = pause
                self.menu.isHidden = !pause
                self.confirm.isHidden = true
        })
        self.pauseNode.position = CGPoint(x: spriteSize + 8, y: spriteSize + 8)
        self.addChild(self.pauseNode)
        pauseNode.isHidden = true
        
        scoreNode = SKLabelNode(text: "3")
        scoreNode.fontName = "HelveticaNeue"
        scoreNode.fontSize = size.height / 30
        scoreNode.fontColor = UIColor.white
        scoreNode.position = CGPoint(x: 20, y: size.height - scoreNode.frame.height - 25)
        self.addChild(scoreNode)
        
        let menuSize : CGSize
        if (size.height > size.width){
            menuSize = CGSize(width: size.width*0.7, height: size.height*0.4)
        }else{
            menuSize = CGSize(width: size.width*0.5, height: size.height*0.6)
        }
        menu = SKShapeNode(rectOf: menuSize)
        menu.fillColor = UIColor.white
        menu.fillTexture = SKTexture.init(image: UIImage(named: "game.scnassets/Textures/gp.png")!)
        menu.strokeColor = UIColor.clear
        menu.position = CGPoint(x: size.width/2, y: size.height/2)
        
        self.addChild(menu)
        
        confirm = SKShapeNode(rectOf: CGSize(width: size.width*0.8, height: size.height*0.3))
        confirm.fillColor = UIColor.white
        confirm.fillTexture = SKTexture.init(image: UIImage(named: "game.scnassets/Textures/gp.png")!)
        confirm.strokeColor = UIColor.clear
        confirm.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(confirm)
        
        let confirmTitle = SKLabelNode(text: "ａｒｅ ｙｏｕ ｓｕｒｅ ?")
        confirmTitle.fontName = "HelveticaNeue"
        confirmTitle.fontColor = UIColor.black
        let scoreScalingFactor = min(confirm.frame.width / (confirmTitle.frame.width*1.2), confirm.frame.height / confirmTitle.frame.height)
        confirmTitle.fontSize *= scoreScalingFactor
        confirmTitle.position = CGPoint(x: 0, y: confirmTitle.frame.height / 2.0)
        confirm.addChild(confirmTitle)
        confirm.isHidden = true
        
        let yesButton = GameButtonNode(size: size, text: "ｙｅｓ", fontSize: size.width/20, callback: {() in
            game.dismiss(animated: true, completion: nil)
        })
        yesButton.position = CGPoint(x: -yesButton.frame.width, y: -yesButton.frame.height)
        confirm.addChild(yesButton)
        
        let noButton = GameButtonNode(size: size, text: "ｎｏ", fontSize: size.width/20, callback: {() in
            self.confirm.isHidden = true
        })
        noButton.position = CGPoint(x: noButton.frame.width, y: -yesButton.frame.height)
        confirm.addChild(noButton)
        
        let fontSize : CGFloat
        if (size.height > size.width){
            fontSize = size.width/20
        }else{
            fontSize = size.height/20
        }
        
        continueButton = GameButtonNode(size: size, text: "ｃｏｎｔｉｎｕｅ", fontSize: fontSize, callback: {() in
            self.pause = !self.pause
            self.pauseNode.start()
            self.confirm.isHidden = true
            self.menu.isHidden = true
        })
        continueButton.position = CGPoint(x: 0, y: continueButton.frame.height)
        menu.addChild(continueButton)
        
        returnButton = GameButtonNode(size: size, text: "ｒｅｔｕｒｎ", fontSize: fontSize, callback: {() in
            if self.stop {
                game.dismiss(animated: true, completion: nil)
            }
            else {
                self.confirm.isHidden = false
            }
        })
        returnButton.position = CGPoint(x: 0, y: -continueButton.frame.height)
        menu.addChild(returnButton)
        
        menu.isHidden = true
        
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = false
        
        pause = true
        
    }
    
    func setScoreNode(score: String) {
        scoreNode.text = score
    }
    
    func startReady() {
        readyLabel = SKLabelNode()
        readyLabel.horizontalAlignmentMode = .center
        readyLabel.verticalAlignmentMode = .baseline
        readyLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        readyLabel.fontName = "HelveticaNeue"
        readyLabel.fontColor = SKColor.black
        readyLabel.fontSize = size.height / 30
        readyLabel.zPosition = 100
        readyLabel.text = "ｒｅａｄｙ"
        
        self.addChild(readyLabel)
        
        let start = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run(startAction)])
        
        run(SKAction.sequence([SKAction.repeat(start, count: 2), SKAction.run(endCountdown)]))
        
    }
    
    func startAction() {
        readyLabel.text = "ｓｔａｒｔ"
    }
    
    func endCountdown() {
        readyLabel.removeFromParent()
        pauseNode.isHidden = false
        pause = false
    }
    
    func won(text: String, point: Int) {
        continueButton.removeFromParent()
        pauseNode.removeFromParent()
        
        let pointsNode = SKLabelNode(text: "ｙｏｕ ｇａｉｎｅｄ " + String(point) + " ｐｏｉｎｔｓ")
        pointsNode.fontName = "HelveticaNeue"
        let scoreScalingFactor = min(menu.frame.width / (pointsNode.frame.width), menu.frame.height / pointsNode.frame.height)
        pointsNode.fontSize *= scoreScalingFactor
        pointsNode.position = CGPoint(x: 0, y: pointsNode.frame.height / 2.0)
        menu.addChild(pointsNode)
        
        let textNode = SKLabelNode(text: text)
        textNode.fontName = "HelveticaNeue"
        let scalingFactor = min(menu.frame.width / (1.2 * textNode.frame.width), menu.frame.height / textNode.frame.height)
        textNode.fontSize *= scalingFactor
        textNode.position = CGPoint(x: 0, y: 2 * pointsNode.frame.height + textNode.frame.height / 2)
        menu.addChild(textNode)
        
        pause = true
        stop = true
        
        menu.isHidden = false
    }
    
    func lost() {
        continueButton.removeFromParent()
        pauseNode.removeFromParent()
        
        let textNode = SKLabelNode(text: "ｙｏｕ ｌｏｓｔ")
        textNode.fontName = "HelveticaNeue"
        let scalingFactor = min(menu.frame.width / (1.2 * textNode.frame.width), menu.frame.height / textNode.frame.height)
        textNode.fontSize *= scalingFactor
        textNode.position = CGPoint(x: 0, y: textNode.frame.height / 2)
        menu.addChild(textNode)
        
        pause = true
        stop = true
        
        menu.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func transitionChange(size: CGSize) {
        menu.position = CGPoint(x: size.width/2, y: size.height/2)
    }
    
    
}
