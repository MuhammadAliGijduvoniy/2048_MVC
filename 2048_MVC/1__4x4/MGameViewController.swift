//
//  MGameViewController.swift
//  2048_MVC
//
//  Created by MuhammadAli on 03/01/24.
//

import UIKit

let windowWidth = UIScreen.main.bounds.width
let windowHight = UIScreen.main.bounds.height

class MGameViewController: UIViewController, MGameProtocol {   // protocol --- btn va lvl ni updati uchun
    
    internal var buttons: [UIButton] = []
    
    internal var toptitle : UILabel!
    
    internal var model: MGameModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = MGameModel(self)  
        self.view.backgroundColor = .white
        
        initView()
        initSwipe()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.model.startGame()
    }
    
    func initView() {
        toptitle = UILabel(frame: CGRect(x: 20, y: 100, width: windowWidth - 40, height: 50))
        toptitle.text = "2048 -- 4x4"
        toptitle.textAlignment = .center
        toptitle.font = .boldSystemFont(ofSize: 32)
        toptitle.layer.cornerRadius = 12
        toptitle.layer.borderColor = UIColor.black.cgColor
        toptitle.layer.borderWidth = 3
        self.view.addSubview(toptitle)
        initButtons()
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
    
    
    
    func initButtons() {
        
        let spacing: CGFloat = 5
        let spacingLeft: CGFloat = 20
        let buttonAreaa: CGFloat = windowWidth - (2 * spacingLeft)
        let buttonwidht: CGFloat = (buttonAreaa - (5 * spacing)) / 4
        
        let buttonArea = UIButton(frame: CGRect(x: spacingLeft, y: 220, width: buttonAreaa, height: buttonAreaa))
        buttonArea.layer.cornerRadius = 12
        buttonArea.layer.borderColor = UIColor.black.cgColor
        buttonArea.layer.borderWidth = 3
        self.view.addSubview(buttonArea)
        
        
        
        for i in 0 ... 3 {
            for j in 0 ... 3 {
                let button = UIButton(
                    frame: CGRect(
                        x: spacing + CGFloat(j) * (spacing + buttonwidht),
                        y: spacing + CGFloat(i) * (spacing + buttonwidht),
                        width: buttonwidht,
                        height: buttonwidht))
                button.titleLabel?.font = .boldSystemFont(ofSize: 32)
                button.setTitleColor(.black, for: .normal)
                button.setTitle(nil, for: .normal)
                button.layer.cornerRadius = 8
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 3
                button.tag = (4 * i + j)
                buttonArea.addSubview(button)
                buttons.append(button)
            }
        }
    }

    @objc func onSwipe(_ gesture: UISwipeGestureRecognizer) {
        self.model.onSwipeTo(gesture.direction)
    }
    
    func reloadUIButtons(_ arr: [String?]) {
        for i in 0 ... 15 {
                self.buttons[i].setTitle(arr[i], for: .normal)
        }
    }
    
    func updateLevel(_ title: String) {
        self.toptitle.text = title
    }

}
