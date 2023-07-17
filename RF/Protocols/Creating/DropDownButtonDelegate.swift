//
//  DropDownButtonDelegate.swift
//  RF
//
//  Created by 이정동 on 2023/07/17.
//

import Foundation
import UIKit

protocol DropDownButtonDelegate: AnyObject {
    func buttonTapped(_ view: UIView)
    
    func itemSelected(_ item: String)
}
