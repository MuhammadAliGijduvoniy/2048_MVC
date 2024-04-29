//
//  Utilis.swift
//  2048_MVC
//
//  Created by MuhammadAli on 04/01/24.
//

import UIKit

enum GStatus2048 {
    case new
    case old
    case none
}

enum GameLevel: Int {
    case entry
    case low
    case small
    case high
    case upper
    case upperHigh
    case ultraHigh
    case Mega
    
    var next: GameLevel {
        switch self {
        case .entry: return .low
        case .low: return .small
        case .small: return .high
        case .high: return .upper
        case .upper: return .upperHigh
        case .upperHigh: return .ultraHigh
        case .ultraHigh: return .Mega
        case .Mega: return .Mega
        }
    }
    
    var title : String {
        switch self {
        case .entry: return "Entry"
        case .low: return "low"
        case .small: return "small"
        case .high: return "high"
        case .upper: return "upper"
        case .upperHigh: return "upperHigh"
        case .ultraHigh: return "ultraHigh"
        case .Mega: return "Mega"
        }
    }
    
}

struct GIndex {
    var i: Int
    var j: Int
    
    var tag : Int {
        return (i * 5 + j)
    }
    init(i: Int, j: Int) {
        self.i = i
        self.j = j
    }
    
    init(_ tag: Int) {
        self.i = tag / 5
        self.j = tag % 5
    }
    
    
}

struct GModel2048 {
    
    var staus: GStatus2048 = .none
    private var degree: Int = 0
    var tag: Int = 0
    
    var index: GIndex {
        return GIndex(self.tag)
    }
    
    var getDegree: Int {
        return (self.degree)
    }
    
    var title: String? {
        return (self.degree == 0) ? nil : "\(self.degree)"
    }
    
    var backgraundColor: UIColor {
        switch self.degree {
        case 2: return .degree2
        case 4: return .degree4
        case 8: return .degree8
        case 16: return .degree16
        case 32: return .degree32
        case 64: return .degree64
        case 128: return .degree128
        case 256: return .degree256
        case 512: return .degree512
        default: return .white
        }
    }
    
    var titleColor: UIColor {
        switch self.degree {
        case 2: return .yellow
        case 4: return .green
        case 8: return .orange
        default: return .red
        }
    }
    
    init(_ tag: Int) {
        self.staus = .none
        self.degree = 0
        self.tag = tag
    }
    
    mutating func add() {
        if self.degree == 0 {
            self.degree = 2
            self.staus = .old
        } else {
            self.degree *= 2
            self.staus = .new
        }
    }
    
    func isEqual(with element: GModel2048) -> Bool {
        return (self.degree == element.getDegree)
    }
}

extension Array where Element == GModel2048 {
    
    func getEmpty() -> [GModel2048] {
        
        var result = [GModel2048]()
        
        for item in self {
            if item.staus == .none {
                result.append(item)
            }
        }
       return result
    }
}

extension Array where Element == [GModel2048] {
    
    func getEmpties() -> [GModel2048] {
        
        var result = [GModel2048]()
        for item in self {
            result.append(contentsOf: item.getEmpty())
        }
        
        return result
    }
    
    mutating func update(_ newModel: GModel2048) {
        
        let index = newModel.index
        self[index.i][index.j] = newModel
    }
    
    mutating func addRandomElement() {
        if var element = self.getEmpties().randomElement() {
            element.add()
            self.update(element)
        }
    }
    
    mutating func releaseElement(_ index: GIndex) {
        self[index.i][index.j] = GModel2048(index.tag)
    }
    
    mutating func checkFor(_ level: GameLevel) -> Bool {
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                if self[i][j].getDegree == level.rawValue {
                    return true
                }
            }
            
        }
        return false
    }
    
    func getTitles() -> [String?] {
        var result = [String?]()
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                result.append(self[i][j].title)
            }
        }
        return result
    }
}

