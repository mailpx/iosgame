
import Foundation
import UIKit

class HowToPlayViewController : UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight*1.7)
        
        view.addSubview(scrollView)
        
        let returnButton = UIButton()
        returnButton.frame = CGRect(x: 10, y: 50, width: 150, height: 50)
        returnButton.setTitle("ｒｅｔｕｒｎ", for: .normal)
        returnButton.setTitleColor(UIColor.white, for: .normal)
        returnButton.setTitleColor(UIColor.cyan, for: .highlighted)
        returnButton.backgroundColor = UIColor.black
        returnButton.layer.cornerRadius = 2
        returnButton.addTarget(self, action:#selector(returnToMainMenu(sender:)), for: .touchUpInside)
        
        scrollView.addSubview(returnButton)
        
        let title = UILabel()
        title.text = "ｈｏｗ ｔｏ ｐｌａｙ"
        title.font = UIFont(name: "HelveticaNeue", size: screenWidth/15)
        title.textColor = UIColor.black
        title.frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight/7)

        scrollView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: returnButton, attribute: .bottom, multiplier: 1, constant: screenHeight*0.05).isActive = true
        
        let text1 = createText(text: "ｓｌｉｄｅ ｔｈｅ ｓｃｒｅｅｎ ｔｏ ｍｏｖｅ ｔｈｅ ｓｐｈｅｒｅ ｔｏ ｔｈｅ ｓｉｄｅｓ")
        text1.contentSize = CGSize(width: screenWidth, height: screenHeight/7)
        addText(text: text1, view: title)
        
        let imageView1 = UIImageView(image: UIImage(named: "game.scnassets/Images/sphere.png"))
        addImage(imageView: imageView1, width: screenWidth/1.5, height: screenHeight/8, view: text1)
        
        let text2 = createText(text: "ｉｆ ｙｏｕ ｈｉｔ ｔｈｅ ｏｂｓｔａｃｌｅ ｙｏｕ ｇｅｔ ｐｕｓｈｅｄ ｂａｃｋ")
        text2.contentSize = CGSize(width: view.bounds.width, height: screenHeight/7)
        addText(text: text2, view: imageView1)
        
        let imageView2 = UIImageView(image: UIImage(named: "game.scnassets/Images/box.png"))
        addImage(imageView: imageView2, width: screenWidth/2, height: screenHeight/7, view: text2)

        let text3 = createText(text: "ｉｆ ｙｏｕ ｅｎｔｅｒ ｔｈｅ ｐａｌｍ ｙｏｕ ａｒｅ ｓｌｏｗｅｄ ｄｏｗｎ")
        text3.contentSize = CGSize(width: view.bounds.width, height: screenHeight/7)
        addText(text: text3, view: imageView2)
        
        let imageView3 = UIImageView(image: UIImage(named: "game.scnassets/Images/palm.png"))
        addImage(imageView: imageView3, width: screenWidth/2, height: screenHeight/5, view: text3)
        
        let text4 = createText(text: "ｉｆ ｙｏｕ ｔａｋｅ ｔｈｅ ｊｕｉｃｅ ｙｏｕ ｇｅｔ ｍｏｒｅ ｓｐｅｅｄ")
        text4.contentSize = CGSize(width: view.bounds.width, height: screenHeight/7)
        addText(text: text4, view: imageView3)
        
        let imageView4 = UIImageView(image: UIImage(named: "game.scnassets/Images/juice.png"))
        addImage(imageView: imageView4, width: screenWidth/3, height: screenHeight/7, view: text4)
        
        let text5 = createText(text: "ｗｉｎ ｔｈｅ ｇａｍｅ ｔｏ ｇａｉｎ ｐｏｉｎｔｓ ｔｏ ｂｕｙ ｉｎ ｔｈｅ ｓｈｏｐ")
        text5.contentSize = CGSize(width: view.bounds.width, height: screenHeight/7)
        addText(text: text5, view: imageView4)
    }
    
    func addText(text: UITextView, view: UIView) {
        scrollView.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: text, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height*0.04).isActive = true
        text.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func addImage(imageView: UIImageView, width: CGFloat, height: CGFloat, view: UIView) {
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height*0.02).isActive = true
    }
    
    func returnToMainMenu(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func createText(text: String) -> UITextView{
        let textView = UITextView()
        textView.text = text
        textView.textColor = UIColor.black
        textView.contentSize = CGSize(width: self.view.bounds.width, height: 10000)
        textView.isEditable = false
        textView.font = UIFont(name: "HelveticaNeue", size: view.bounds.width/20)
        textView.isScrollEnabled = false
        
        return textView
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
