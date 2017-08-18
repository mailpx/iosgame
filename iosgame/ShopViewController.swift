
import Foundation
import UIKit

class ShopViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let colors: Colors! = Colors()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        myCell.layer.borderColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        myCell.layer.borderWidth = 3
        
        let stack = UIStackView(frame: CGRect(x: 50, y: 0, width: 180, height: 90))
        stack.axis = UILayoutConstraintAxis.horizontal;
        stack.distribution = UIStackViewDistribution.equalCentering;
        stack.alignment = UIStackViewAlignment.center;
        myCell.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stack.widthAnchor.constraint(equalToConstant: 150).isActive = true
        NSLayoutConstraint(item: stack, attribute: .topMargin, relatedBy: .equal, toItem: myCell, attribute: .topMargin, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: stack, attribute: .left, relatedBy: .equal, toItem: myCell, attribute: .left, multiplier: 1, constant: 15).isActive = true
        
        let color = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        color.backgroundColor = colors.colors[indexPath.row].color
        color.heightAnchor.constraint(equalToConstant: 50).isActive = true
        color.widthAnchor.constraint(equalToConstant: 50).isActive = true
        stack.addArrangedSubview(color)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setTitle("ｂｕｙ", for: .normal)
        button.setTitleColor(UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.cyan, for: .highlighted)
        button.layer.borderColor = UIColor(red: 0.98, green: 0.83, blue:0.88, alpha: 1).cgColor
        button.layer.borderWidth = 2
        stack.addArrangedSubview(button)
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
}
