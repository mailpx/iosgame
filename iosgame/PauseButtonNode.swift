
import Foundation
import SpriteKit

class PauseButtonNode : SKSpriteNode {
    
    var pause = false
    var callback:((Bool) -> ())? = nil
    
    init(spriteSize: CGFloat, callback: @escaping ((Bool) -> ())) {
        let texture = SKTexture(imageNamed: "game.scnassets/Textures/Pause Button.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: spriteSize, height: spriteSize))

        self.isUserInteractionEnabled = true
        
        self.callback = callback
    }
    
    func start() {
        self.texture = SKTexture(imageNamed: "game.scnassets/Textures/Play Button.png")
        pause = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pause {
            self.texture = SKTexture(imageNamed: "game.scnassets/Textures/Play Button.png")
        }
        else {
            self.texture = SKTexture(imageNamed: "game.scnassets/Textures/Pause Button.png")
        }
        if(self.callback != nil){
            self.callback!(!pause)
        }
        
        pause = !pause
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
