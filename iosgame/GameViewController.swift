import UIKit
import SceneKit
import SpriteKit

class GameViewController: UIViewController {
    var scnView:SCNView!
    var scnScene: SCNScene!
    
    var horizontalCameraNode: SCNNode!
    var verticalCameraNode: SCNNode!
    
    var overlay : OverlayView!
    
    var touchX: CGFloat = 0
    var playerX: Float = 0
    
    var playerNode: SCNNode!
    
    var spawnTime: TimeInterval = 0
    
    var speed: Float = 2
    
    var pause = false
    var won = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnScene = SCNScene(named: "SceneKit Scene.scn")
        
        setupScene()
        setupNodes()
        setupSounds()
        setUpPlayerNode()
        
        scnView.scene = scnScene
    }
    
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnView.showsStatistics = true
        
        scnView.isPlaying = true
        scnScene.physicsWorld.contactDelegate = self
        
        overlay = OverlayView(size: self.view.bounds.size, game: self)
        scnView.overlaySKScene = overlay
    }
    
    func setupNodes() {
        
        horizontalCameraNode = scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)!
        verticalCameraNode = scnScene.rootNode.childNode(withName: "VerticalCamera", recursively: true)!
        if self.view.bounds.size.height > self.view.bounds.size.width {
            scnView.pointOfView = verticalCameraNode
        } else {
            scnView.pointOfView = horizontalCameraNode
        }
        
        //create floor
        let floor = SCNPlane()
        
        let floorNode = SCNNode()
        floorNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(-90), 0, 0)
        floorNode.scale = SCNVector3(10, 1000, 1)
        floorNode.position = SCNVector3(0, 0.1, -475)
        
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = "game.scnassets/Textures/g.jpg"
        floorMaterial.diffuse.contentsTransform = SCNMatrix4MakeScale(2,200,0);
        floorMaterial.diffuse.wrapT = SCNWrapMode.repeat;
        floorMaterial.diffuse.wrapS = SCNWrapMode.repeat;
        floor.materials = [floorMaterial]
        
        floorNode.geometry = floor;

        scnScene.rootNode.addChildNode(floorNode);
        
        //create decoration
        let numDecoration = 50
        for i in 1...numDecoration {
            
            let leftImage = SCNPlane()
            let rightImage = SCNPlane()
            
            let nodeMaterial = SCNMaterial()
            var scaleNode = SCNVector3()
            var y = 0;
            switch i%2 {
            case 0:
                if i%2 == 0 {
                    nodeMaterial.diffuse.contents = "game.scnassets/Textures/palm.png"
                } else {
                    nodeMaterial.diffuse.contents = "game.scnassets/Textures/palm1.png"
                }
                scaleNode.x = 7
                scaleNode.y = 10
                y = 5
                break
            case 1:
                nodeMaterial.diffuse.contents = "game.scnassets/Textures/am.gif"
                scaleNode.x = 4
                scaleNode.y = 10
                y = 5
                break
            default:
                break
            }
            
            leftImage.materials = [nodeMaterial]
            rightImage.materials = [nodeMaterial]
            
            let leftNode = SCNNode()
            let rightNode = SCNNode()
            
            leftNode.geometry = leftImage;
            leftNode.scale = scaleNode
            leftNode.position = SCNVector3(-10, y, 30-20*i)
            rightNode.geometry = rightImage;
            rightNode.scale = scaleNode
            rightNode.position = SCNVector3(10, y, 30-20*i)
            
            scnScene.rootNode.addChildNode(leftNode)
            scnScene.rootNode.addChildNode(rightNode)
            
            
        }
        
        //create box
        let numBox = 30
        for i in 1...numBox {
            let box = SCNBox()
            
            let boxMaterial = SCNMaterial()
            boxMaterial.diffuse.contents = "game.scnassets/Textures/w.jpg"
            box.materials = [boxMaterial]
            
            let boxNode = SCNNode()
            boxNode.scale = SCNVector3(3, 3, 3)
            let posx = Int(arc4random_uniform(6)) - 3
            boxNode.position = SCNVector3(posx, 1, 20-30*i)
            boxNode.geometry = box
            boxNode.name = "box"
            
            boxNode.physicsBody = SCNPhysicsBody.static()
            boxNode.physicsBody!.contactTestBitMask = 1
            
            scnScene.rootNode.addChildNode(boxNode)
        }
        
        //create Leaf
        let numLeaf = 3
        for i in 1...numLeaf {
            let leaf = SCNPlane()
            
            let leafMaterial = SCNMaterial()
            leafMaterial.diffuse.contents = "game.scnassets/Textures/plant.png"
            leaf.materials = [leafMaterial]
            
            let leafNode = SCNNode()
            leafNode.scale = SCNVector3(3, 4, 3)
            let posx = Int(arc4random_uniform(6)) - 3
            let posz = Int(arc4random_uniform(250))
            leafNode.position = SCNVector3(posx, 2, -300*(i-1) - posz)
            leafNode.geometry = leaf
            leafNode.name = "leaf"
            
            leafNode.physicsBody = SCNPhysicsBody.static()
            leafNode.physicsBody!.contactTestBitMask = 2
            
            scnScene.rootNode.addChildNode(leafNode)
        }
        
        //create juice
        let numJuice = 3
        for i in 1...numJuice {
            let juice = SCNPlane()
            
            let juiceMaterial = SCNMaterial()
            juiceMaterial.diffuse.contents = "game.scnassets/Textures/juice.png"
            juice.materials = [juiceMaterial]
            
            let juiceNode = SCNNode()
            juiceNode.scale = SCNVector3(2, 2, 2)
            let posx = Int(arc4random_uniform(6)) - 3
            let posz = Int(arc4random_uniform(250))
            juiceNode.position = SCNVector3(posx, 2, -300*(i-1) - posz)
            juiceNode.geometry = juice
            juiceNode.name = "leaf"
            
            juiceNode.physicsBody = SCNPhysicsBody.static()
            juiceNode.physicsBody!.contactTestBitMask = 4
            
            scnScene.rootNode.addChildNode(juiceNode)
        }
        
    }
    
    func setupSounds() {
        
    }
    
    func setUpPlayerNode() {
        let player = SCNSphere(radius: 1)
        
        let data = DataManager()
        let playerMaterial = SCNMaterial()
        playerMaterial.diffuse.contents = data.getColor()
        player.materials = [playerMaterial]
        
        playerNode = SCNNode()
        playerNode.position = SCNVector3(2,1.5,15)
        playerNode.geometry = player
        playerNode.name = "player"
        playerNode.physicsBody = SCNPhysicsBody.kinematic()
        playerNode.physicsBody!.contactTestBitMask = 7
        
        scnScene.rootNode.addChildNode(playerNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: scnView)
            touchX = location.x
            playerX = playerNode.position.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if overlay.pause {
                return
            }
            
            let location = touch.location(in: scnView)
            playerNode.position.x = playerX + (Float(location.x - touchX) * 0.05)

            if playerNode.position.x > 4 {
                playerNode.position.x = 4
            } else if playerNode.position.x < -4 {
                playerNode.position.x = -4
            }
        }
    }
    
    func createExplosion(geometry: SCNGeometry, position: SCNVector3,
                         rotation: SCNVector4) {
        let explosion =
            SCNParticleSystem(named: "Explode.scnp", inDirectory:
                "game.scnassets/Particle")!
        explosion.emitterShape = geometry
        explosion.birthLocation = .surface
        
        let rotationMatrix =
            SCNMatrix4MakeRotation(rotation.w, rotation.x,
                                   rotation.y, rotation.z)
        let translationMatrix =
            SCNMatrix4MakeTranslation(position.x, position.y,
                                      position.z)
        let transformMatrix =
            SCNMatrix4Mult(rotationMatrix, translationMatrix)
        
        scnScene.addParticleSystem(explosion, transform: transformMatrix)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        let deviceOrientation = UIDevice.current.orientation
        switch(deviceOrientation) {
        case .portrait:
            scnView.pointOfView = verticalCameraNode
        default:
            scnView.pointOfView = horizontalCameraNode
        }
        overlay.transitionChange(size: size)
    }
    
}

extension GameViewController: SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let bit = (contact.nodeA.physicsBody?.contactTestBitMask)! & (contact.nodeB.physicsBody?.contactTestBitMask)!
        if(bit == 1) {
            createExplosion(geometry: playerNode.geometry!, position: playerNode.presentation.position,
                        rotation: playerNode.presentation.rotation)
            playerNode.position.z += 20
            verticalCameraNode.position.z += 20
            horizontalCameraNode.position.z += 20
        } else if(bit == 2) {
            speed = 1
        } else if(bit == 4) {
            speed = 3
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time:
        TimeInterval) {
        
        if time > spawnTime {
            spawnTime = time + TimeInterval(0.1)
        
            if playerNode.position.z < -950 && !won {
                overlay.won(text: "ｙｏｕ ｗｏｎ", point: 3)
                won = true
            
                let data = DataManager()
                data.addPoints(points: 3)
            }
            if overlay.pause {
                return
            }
            playerNode.position.z -= speed
            verticalCameraNode.position.z -= speed
            horizontalCameraNode.position.z -= speed
        }
    }
}

