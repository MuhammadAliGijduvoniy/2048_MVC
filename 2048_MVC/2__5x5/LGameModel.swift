//
//  LGameModel.swift
//  2048_MVC
//
//  Created by MuhammadAli on 04/01/24.
//

import UIKit

class LGameModel {
    
   private var matrix = [[GModel2048]]()
    
   private var delegate: LGameProtocol?
    
    private var isFirstTime: Bool = true
    
    var level: GameLevel = .entry
    
    init(_ delegate: LGameProtocol? = nil) {
        self.delegate = delegate
        self.initModel()
    }
    
    private func initModel() {
        for i in 0 ... 4 {
            var array = [GModel2048]()
            for j in 0 ... 4 {
                let tag = 5 * i + j
                array.append(GModel2048(tag))
            }
            matrix.append(array)
        }
    }
    func startGame() {
        renewItem()
    }
    
    private func renewItem() {
        getRandomElement()
        self.delegate?.reloadUIButtons(self.matrix.getTitles())
    }
    
    private func renewMatrix() {
        self.delegate?.reloadUIButtons(self.matrix.getTitles())
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
            self.renewItem()
        })
    }
    
    private func getRandomElement() {
        if isFirstTime {
            self.matrix.addRandomElement()
            self.matrix.addRandomElement()
            isFirstTime = false
        } else {
            self.matrix.addRandomElement()
        }
    }
    
    func onToSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .down: return moveToDown()
        case .left: return moveToLeft()
        case .right: return moveToRight()
        case .up: return moveToUp()
        default: print("break")
        }
    }
    
    func moveToLeft() {
        for i in 0 ... 4 {
            for j in stride(from: 4, through: 0, by: -1) {
                if self.matrix[i][j].staus != .none {
                    if (j - 1) >= 0 {
                        if self.matrix[i][j - 1].staus == .none {
                            self.matrix[i][j - 1] = matrix[i][j]
                            matrix.releaseElement(GIndex(i: i, j: j))
                            if (j + 1) <= 4 && self.matrix[i][j + 1].staus != .none {
                                self.matrix[i][j] = self.matrix[i][j + 1]
                                self.matrix.releaseElement(GIndex(i: i, j: j + 1))
                            }
                        } else if self.matrix[i][j - 1].isEqual(with: self.matrix[i][j]) {
                            self.matrix[i][j - 1].add()
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            checkLevel()
                            if (j + 1) <= 4 && self.matrix[i][j + 1].staus != .none {
                                self.matrix[i][j] = self.matrix[i][j + 1]
                                self.matrix.releaseElement(GIndex(i: i, j: j + 1))
                            }
                        }
                    }
                }
            }
        }
        renewMatrix()
    }
    
    func moveToUp() {
        for i in stride(from: 4, through: 0, by: -1) {
            for j in stride(from: 4, through: 0, by: -1) {
                if self.matrix[i][j].staus != .none {
                    if (i - 1) >= 0 {
                        if self.matrix[i - 1][j].staus == .none {
                            self.matrix[i - 1][j] = self.matrix[i][j]
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            if (i + 1) <= 4 && self.matrix[i + 1][j].staus != .none {
                                self.matrix[i][j] = self.matrix[i + 1][j]
                                self.matrix.releaseElement(GIndex(i: i, j: j))
                            }
                        } else if self.matrix[i - 1][j].isEqual(with: self.matrix[i][j]) {
                            self.matrix[i - 1][j].add()
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            if (i + 1) <= 4 && self.matrix[i + 1][j].staus != .none {
                                self.matrix[i][j] = self.matrix[i + 1][j]
                                self.matrix.releaseElement(GIndex(i: i, j: j))
                            }
                        }
                    }
                }
            }
        }
          renewMatrix()
    }
    
    func moveToRight() {
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                if self.matrix[i][j].staus != .none {
                    if (j + 1) <= 4 {
                        if self.matrix[i][j + 1].staus == .none {
                            self.matrix[i][j + 1] = self.matrix[i][j]
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            if (j - 1) >= 0 && self.matrix[i][j - 1].staus != .none {
                                self.matrix[i][j] = self.matrix[i][j - 1]
                                self.matrix.releaseElement(GIndex(i: i, j: j - 1))
                            }
                        } else if self.matrix[i][j + 1].isEqual(with: self.matrix[i][j]) {
                            self.matrix[i][j + 1].add()
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            checkLevel()
                            if (j - 1) >= 0 && self.matrix[i][j - 1].staus != .none {
                                self.matrix[i][j] = self.matrix[i][j - 1]
                                self.matrix.releaseElement(GIndex(i: i, j: j - 1))
                            }
                        }
                    }
                }
            }
        }
        renewMatrix()
    }
    
    func moveToDown() {
        for i in 0 ... 4 {
            for j in stride(from: 4, through: 0, by: -1) {
                if self.matrix[i][j].staus != .none {
                    if (i + 1) <= 4 {
                        if self.matrix[i + 1][j].staus == .none {
                            self.matrix[i + 1][j] = self.matrix[i][j]
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            if (i - 1) >= 0 && self.matrix[i - 1][j].staus != .none {
                                self.matrix[i][j] = self.matrix[i - 1][j]
                                self.matrix.releaseElement(GIndex(i: i - 1, j: j))
                            }
                        } else if self.matrix[i + 1][j].isEqual(with: self.matrix[i][j]) {
                            self.matrix[i + 1][j].add()
                            self.matrix.releaseElement(GIndex(i: i, j: j))
                            if (i - 1) >= 0 && self.matrix[i - 1][j].staus != .none {
                                self.matrix[i][j] = self.matrix[i - 1][j]
                                self.matrix.releaseElement(GIndex(i: i - 1, j: j))
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
