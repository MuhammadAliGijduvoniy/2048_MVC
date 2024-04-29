//
//  MGameModel.swift
//  2048_MVC
//
//  Created by MuhammadAli on 03/01/24.


import UIKit


// viewModel
class MGameModel {
    
    private var delegate: MGameProtocol?
    
    private var matrix =  [[GModel2048]]()
    
    private var isFirstTime: Bool = true
    
    private var level: GameLevel = .entry
    
    
    
    init(_ delegate: MGameProtocol) {
        self.delegate = delegate
        self.initModels()
    }
    
    private func initModels() {
        for i in 0 ... 3 {
            var array = [GModel2048]()
            for j in 0 ... 3 {
                let tag = (4 * i + j)
                array.append(GModel2048(tag))
            }
            matrix.append(array)
        }
    }
    
    func startGame() {
        self.reNewItems()
    }
    
    private func reNewItems() {
        self.giveRandomElement()
        self.delegate?.reloadUIButtons(self.matrix.getTitles())
    }
    
    private func renewMatrix() {
        self.delegate?.reloadUIButtons(self.matrix.getTitles())
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { timer in
            self.reNewItems()
        })
    }
    
    
    private func giveRandomElement() {
        if isFirstTime {
            self.matrix.addRandomElement()
            self.matrix.addRandomElement()
            isFirstTime = false
        } else {
            self.matrix.addRandomElement()
        }
    }
    
    func onSwipeTo(_ deriction: UISwipeGestureRecognizer.Direction) {
        switch deriction {
        case .down : moveDown()
        case .up: moveUp()
        case .left:moveLeft()
        case .right: moveRight()
        default : break
        }
    }
    
    func moveRight() {
        for i in 0 ... 3 {
            for j in 0 ... 3 {
                if matrix[i][j].staus != .none {
                    if (j + 1) < 4 {
                        if matrix[i][j + 1].staus == .none {
                            matrix[i][j + 1] = matrix[i][j]
                            matrix.releaseElement(GIndex(i: i, j: j))
                            if (j - 1) >= 0 && matrix[i][j - 1].staus != .none {
                                matrix[i][j] = matrix[i][j - 1]
                                matrix.releaseElement(GIndex(i: i, j: j - 1))
                            }
                        } else if matrix[i][j + 1].isEqual(with: matrix[i][j]) {
                            matrix[i][j + 1].add()
                            matrix.releaseElement(GIndex(i: i, j: j))
                            checkLevel()
                            if j - 1 >= 0 && matrix[i][j - 1].staus  != .none {
                                matrix[i][j] = matrix[i][j - 1]
                                matrix.releaseElement(GIndex(i: i, j: j))
                            }
                        }
                    }
                }
            }
        }
        renewMatrix()
    }
    
    func moveLeft() {
        for i in 0 ... 3 {
            
            for j in stride(from: 3, through: 0, by: -1) {
                
                if matrix[i][j].staus != .none {
                    
                    if (j - 1) >= 0 {
                        
                        if matrix[i][j - 1].staus == .none {
                            
                            matrix[i][j - 1] = matrix[i][j]
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            if (j + 1) < 4  && matrix[i][j + 1].staus != .none {
                                
                                matrix[i][j] = matrix[i][j + 1]
                                
                                matrix.releaseElement(GIndex(i: i, j: j + 1))
                            }
                            
                        } else if matrix[i][j - 1].isEqual(with: matrix[i][j]) {
                            
                            matrix[i][j - 1].add()
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            self.checkLevel()
                            
                            
                            if (j + 1) < 4  && matrix[i][j + 1].staus != .none {
                                
                                matrix[i][j] = matrix[i][j + 1]
                                
                                matrix.releaseElement(GIndex(i: i, j: j + 1))
                            }
                        }
                    }
                }
            }
        }
        
        renewMatrix()
    }
    
    func moveUp() {
        
        for i in stride(from: 3, through: 0, by: -1) {
            for j in 0 ... 3 {
                if matrix[i][j].staus != .none {
                    
                    if (i - 1) >= 0 {
                        
                        if matrix[i - 1][j].staus == .none {
                            
                            matrix[i - 1][j] = matrix[i][j]
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            if (i + 1) < 4 && matrix[i + 1][j].staus != .none {
                                
                                matrix[i][j] = matrix[i + 1][j]
                                
                                matrix.releaseElement(GIndex(i: i + 1 , j: j))
                            }
                        } else if matrix[i - 1][j].isEqual(with: matrix[i][j]) {
                            
                            matrix[i - 1][j].add()
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            self.checkLevel()
                            
                            if (i + 1) < 4 && matrix[i + 1][j].staus != .none {
                                
                                matrix[i][j] = matrix[i + 1][j]
                                
                                matrix.releaseElement(GIndex(i: i + 1, j: j))
                            }
                        }
                    }
                }
            }
        }
        
       renewMatrix()
    }
    
    func moveDown() {
        
        for i in 0 ... 3 {
            
            for j in 0 ... 3 {
                
                if matrix[i][j].staus != .none {
                    
                    if (i + 1) < 4 {
                        
                        if matrix[i + 1][j].staus == .none {
                            
                            matrix[i + 1][j] = matrix[i][j]
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            if (i - 1) >= 0 && matrix[i - 1][j].staus != .none {
                                
                                matrix[i][j] = matrix[i - 1][j]
                                
                                matrix.releaseElement(GIndex(i: i - 1, j: j))
                            }
                            
                        } else if matrix[i + 1][j].isEqual(with: matrix[i][j]) {
                            
                            matrix[i + 1][j].add()
                            
                            matrix.releaseElement(GIndex(i: i, j: j))
                            
                            self.checkLevel()
                            
                            if (i - 1) >= 0 && matrix[i - 1][j].staus != .none {
                                
                                matrix[i][j] = matrix[i - 1][j]
                                
                                matrix.releaseElement(GIndex(i: (i - 1), j: j))
                            }
                        }
                    }
                }
            }
        }
       renewMatrix()
    }
    
    private func checkLevel() {
        if self.matrix.checkFor(level.next) {
            self.level = self.level.next
            self.delegate?.updateLevel(self.level.title)
        }
    }
}


