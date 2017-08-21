
import Foundation
import UIKit

class ShopViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let data: DataManager! = DataManager()
    let colors: Colors! = Colors()
    
    let price = 3
    
    var pointsLabel: UILabel!
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        createRetrunButton()
        
        createPointsLabel()
        
        data.buyColor(colorName: colors.colors[0].colorName)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: screenHeight*0.05, left: screenWidth*0.1, bottom: screenHeight*0.1, right: screenWidth*0.05)
        layout.itemSize = CGSize(width: 200, height: 100)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        let image = #imageLiteral(resourceName: "shop")
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.init(patternImage: image)
        self.view.addSubview(myCollectionView)
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.heightAnchor.constraint(equalToConstant: screenHeight*0.85).isActive = true
        myCollectionView.widthAnchor.constraint(equalToConstant: screenWidth*0.9).isActive = true
        NSLayoutConstraint(item: myCollectionView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: screenHeight*0.125).isActive = true
        NSLayoutConstraint(item: myCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: screenWidth*0.05).isActive = true
        
    }
    
    func createRetrunButton() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let returnButton = UIButton()
        returnButton.setTitle("ｒｅｔｕｒｎ", for: .normal)
        returnButton.setTitleColor(UIColor.white, for: .normal)
        returnButton.setTitleColor(UIColor.cyan, for: .highlighted)
        returnButton.backgroundColor = UIColor.black
        returnButton.layer.cornerRadius = 2
        returnButton.addTarget(self, action:#selector(returnToMainMenu(sender:)), for: .touchUpInside)
        self.view.addSubview(returnButton)
        
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.widthAnchor.constraint(equalToConstant: screenWidth*0.35).isActive = true
        returnButton.heightAnchor.constraint(equalToConstant: screenHeight*0.05).isActive = true
        NSLayoutConstraint(item: returnButton, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: screenHeight*0.02).isActive = true
        NSLayoutConstraint(item: returnButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: screenWidth*0.1).isActive = true
    }
    
    func returnToMainMenu(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func createPointsLabel() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        pointsLabel = UILabel()
        pointsLabel.text = String(data.getPoints()) + " ｐｏｉｎｔｓ"

        self.view.addSubview(pointsLabel)
        
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.widthAnchor.constraint(equalToConstant: screenWidth*0.4).isActive = true
        pointsLabel.heightAnchor.constraint(equalToConstant: screenHeight*0.05).isActive = true
        NSLayoutConstraint(item: pointsLabel, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: screenHeight*0.02).isActive = true
        NSLayoutConstraint(item: pointsLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: screenWidth*0.5).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)

        if cell.contentView.subviews.count != 0 {
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
        }
        
        cell.layer.borderColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        cell.layer.borderWidth = 3
        
        let stack = UIStackView(frame: CGRect(x: 50, y: 0, width: 180, height: 90))
        stack.axis = UILayoutConstraintAxis.horizontal;
        stack.distribution = UIStackViewDistribution.equalCentering;
        stack.alignment = UIStackViewAlignment.center;
        cell.contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stack.widthAnchor.constraint(equalToConstant: 180).isActive = true
        NSLayoutConstraint(item: stack, attribute: .topMargin, relatedBy: .equal, toItem: cell, attribute: .topMargin, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: stack, attribute: .left, relatedBy: .equal, toItem: cell, attribute: .left, multiplier: 1, constant: 15).isActive = true
        
        let color = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        color.image = colors.colors[indexPath.row].color
        color.heightAnchor.constraint(equalToConstant: 50).isActive = true
        color.widthAnchor.constraint(equalToConstant: 50).isActive = true
        stack.addArrangedSubview(color)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.tag = indexPath.row + 1
        if data.isColorBought(colorName: colors.colors[indexPath.row].colorName) {
            if(data.getSettedColor() == colors.colors[indexPath.row].colorName) {
                button.setTitle("ｓｅｔｔｅｄ", for: .normal)
            } else {
                button.setTitle("ｓｅｔ", for: .normal)
                button.addTarget(self, action: #selector(setColor(sender:)), for: .touchUpInside)
            }
        } else {
            button.setTitle("ｂｕｙ ｗｉｔｈ " + String(price) + " ｐｏｉｎｔｓ", for: .normal)
            button.titleLabel?.minimumScaleFactor = 0.5
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.contentEdgeInsets = UIEdgeInsetsMake(25, 0, 25, 0)
            button.addTarget(self, action: #selector(buyColor(sender:)), for: .touchUpInside)
            
        }
        
        button.setTitleColor(UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.cyan, for: .highlighted)
        button.layer.borderColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        button.layer.borderWidth = 2
        
        stack.addArrangedSubview(button)
        
        return cell
    }
    
    func setColor(sender: UIButton){
        
        if let buttonView = self.view.viewWithTag(colors.getColorIndex(colorName: data.getSettedColor()) + 1) {
            if buttonView is UIButton {
                let button = buttonView as! UIButton
                button.setTitle("ｓｅｔ", for: .normal)
                button.addTarget(self, action: #selector(setColor(sender:)), for: .touchUpInside)
            }
        }
        
        data.setColor(colorName: colors.colors[sender.tag - 1].colorName)
        sender.removeTarget(self, action: #selector(setColor(sender:)), for: .touchUpInside)
        sender.setTitle("ｓｅｔｔｅｄ", for: .normal)
    }
    
    func buyColor(sender: UIButton){
        if data.getPoints() >= price  {
            data.buyColor(colorName: colors.colors[sender.tag - 1].colorName)
            data.addPoints(points: -price)
            
            sender.removeTarget(self, action: #selector(buyColor(sender:)), for: .touchUpInside)
            sender.addTarget(self, action: #selector(setColor(sender:)), for: .touchUpInside)
            sender.setTitle("ｓｅｔ", for: .normal)
            sender.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            pointsLabel.text = String(data.getPoints()) + " ｐｏｉｎｔｓ"
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
