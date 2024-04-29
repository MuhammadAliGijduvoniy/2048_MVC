//
//  LGameViewController.swift
//  2048_MVC
//
//  Created by MuhammadAli on 04/01/24.
//

import UIKit

let windowWidthh = UIScreen.main.bounds.width
let windowHeightt = UIScreen.main.bounds.height

class LGameViewController: UIViewController , LGameProtocol{
    
    private var btns: [UIButton] = []
    
    private var model: LGameModel!
    
    var topLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = LGameModel(self)
        self.view.backgroundColor = .white
        
        initView()
        initSwipe()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.model.startGame()
    }
    
    func initView() {
        
       topLabel  = UILabel(
            frame: CGRect(
                x: 20,
                y: 100,
                width: windowWidth - 40,
                height: 50))
        topLabel.layer.cornerRadius = 12
        topLabel.layer.borderColor = UIColor.black.cgColor
        topLabel.layer.borderWidth = 3
        topLabel.textAlignment = .center
        topLabel.font = .boldSystemFont(ofSize: 32)
        topLabel.text = "2048 -- 5x5"
        self.view.addSubview(topLabel)
        
        let spacing: CGFloat = 5
        let spacingLeftRight: CGFloat = 20
        let btnArea: CGFloat = windowWidth - (spacingLeftRight * 2)
        let btnWidth: CGFloat = (btnArea - (spacing * 6)) / 5
        
        let btnContainer = UIView(
            frame: CGRect(
                x: spacingLeftRight,
                y: topLabel.frame.maxY + 100,
                width: btnArea,
                height: btnArea))
        btnContainer.layer.cornerRadius = 12
        btnContainer.layer.borderColor = UIColor.black.cgColor
        btnContainer.layer.borderWidth = 3
        self.view.addSubview(btnContainer)
        
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                let button = UIButton(
                    frame: CGRect(
                        x: spacing + CGFloat(j) * (spacing + btnWidth),
                        y: spacing + CGFloat(i) * (spacing + btnWidth),
                        width: btnWidth,
                        height: btnWidth))
                button.layer.cornerRadius = 8
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 3
                button.setTitleColor(.black, for: .normal)
                button.setTitle(nil, for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: 32)
                button.tag = (5 * i + j)
                btnContainer.addSubview(button)
                self.btns.append(button)
            }
        }
    }
    
    func initSwipe() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        right.direction = .right
        self.view.addGestureRecognizer(right)
        
        let up = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        up.direction = .up
        self.view.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        down.direction = .down
        self.view.addGestureRecognizer(down)
        
    }
    
    @objc func onSwipe(_ gesture: UISwipeGestureRecognizer) {
        self.model.onToSwipe(gesture.direction)
        self.topLabel.text = self.model.level.title
    }
    
    func reloadUIButtons(_ arr: [String?]) {
        for i in 0 ... 24 {
            btns[i].setTitle(arr[i], for: .normal)
        }
    }
    
    func updateLevel(_ title: String) {
        self.topLabel.text = title
    }


}
