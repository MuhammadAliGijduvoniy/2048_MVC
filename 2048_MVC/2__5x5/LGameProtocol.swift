//
//  LGameProtocol.swift
//  2048_MVC
//
//  Created by MuhammadAli on 04/01/24.
//

import UIKit


protocol LGameProtocol {
    
    func reloadUIButtons(_ arr: [String?])
    
    func updateLevel(_ title: String)
}
