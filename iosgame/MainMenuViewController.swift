
import Foundation
import UIKit
import AVFoundation

class MAinMenuViewController : UIViewController {
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        setupBackground()
        
        setupStackView()
        
        guard let url = Bundle.main.url(forResource: "game.scnassets/Sounds/sound2", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func setupBackground() {
        let layer : CAGradientLayer = CAGradientLayer()
        
        let color0 = UIColor(red: 0.89, green: 0.93, blue:0.98, alpha: 1).cgColor
        let color1 = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        
        let gradientColors :[CGColor] = [color0, color1]
        layer.colors = gradientColors
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        if self.view.bounds.height > self.view.bounds.width {
            layer.frame = self.view.bounds
        } else {
            layer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.height, height: self.view.bounds.width)
        }
        
        self.view.layer.insertSublayer(layer, at: 0)
    }
    
    func setupStackView() {
        let stack = UIStackView()
        stack.axis = UILayoutConstraintAxis.vertical;
        stack.distribution = UIStackViewDistribution.equalCentering;
        stack.alignment = UIStackViewAlignment.center;

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.heightAnchor.constraint(equalToConstant: screenHeight*0.8).isActive = true
        stack.widthAnchor.constraint(equalToConstant: screenWidth*0.8).isActive = true
        NSLayoutConstraint(item: stack, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: screenHeight*0.1).isActive = true
        NSLayoutConstraint(item: stack, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: screenWidth*0.1).isActive = true
        
        //stackview background
        let subView = UIView()
        let image = #imageLiteral(resourceName: "mainMenu")
        subView.backgroundColor = UIColor(patternImage: image)
        subView.translatesAutoresizingMaskIntoConstraints = false
        stack.addSubview(subView)
        subView.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        subView.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
        subView.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
        
        
        addButtons(stack: stack)
        
    }
    
    func addButtons(stack: UIStackView) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let space1 = UIView()
        space1.widthAnchor.constraint(equalToConstant: screenWidth*0.05).isActive = true
        space1.heightAnchor.constraint(equalToConstant: screenHeight*0.05).isActive = true
        stack.addArrangedSubview(space1)

        let b1 = createButton(title: "ｐｌａｙ")
        stack.addArrangedSubview(b1)
        b1.addTarget(self, action:#selector(game(sender:)), for: .touchUpInside)
        
        let b2 = createButton(title: "ｈｏｗ ｔｏ ｐｌａｙ")
        stack.addArrangedSubview(b2)
        b2.addTarget(self, action:#selector(howToPlay(sender:)), for: .touchUpInside)
        
        let b3 = createButton(title: "ｓｈｏｐ")
        stack.addArrangedSubview(b3)
        b3.addTarget(self, action:#selector(shop(sender:)), for: .touchUpInside)
        
        let space2 = UIView()
        space2.widthAnchor.constraint(equalToConstant: screenWidth*0.05).isActive = true
        space2.heightAnchor.constraint(equalToConstant: screenHeight*0.05).isActive = true
        stack.addArrangedSubview(space2)
    }
    
    func createButton(title: String) -> UIButton {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: screenWidth/20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.cyan, for: .highlighted)
        button.layer.cornerRadius = 2
        button.widthAnchor.constraint(equalToConstant: screenWidth*0.5).isActive = true
        button.heightAnchor.constraint(equalToConstant: screenHeight*0.1).isActive = true
        
        let background = CALayer()
        background.cornerRadius = 2
        background.backgroundColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        background.frame = CGRect(x: 0, y: 0, width: screenWidth*0.5, height: screenHeight*0.1)
        button.layer.insertSublayer(background, at: 0)
        
        let shadow = CALayer()
        shadow.cornerRadius = 2
        shadow.backgroundColor = UIColor(red: 0.89, green: 0.93, blue:0.98, alpha: 0.5).cgColor
        shadow.frame = CGRect(x: 5, y: 5, width: screenWidth*0.5, height: screenHeight*0.1)
        button.layer.insertSublayer(shadow, at: 0)
        
        return button
    }
    
    func game(sender: UIButton){
        performSegue(withIdentifier: "game", sender: nil)
    }
    
    func howToPlay(sender: UIButton){
        performSegue(withIdentifier: "howtoplay", sender: nil)
    }
    
    func shop(sender: UIButton){
        performSegue(withIdentifier: "shop", sender: nil)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
