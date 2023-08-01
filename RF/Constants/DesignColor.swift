//
//  DesignColor.swift
//  RF
//
//  Created by 이정동 on 2023/07/27.
//

import UIKit

enum TextColor {
    case first, secondary
    
    var color: UIColor {
        switch self {
        case .first: return UIColor(hexCode: "3C3A3A")
        case .secondary : return UIColor(hexCode: "A0A0A0")
        }
    }
}

enum ButtonColor {
    case normal, main
    
    var color: UIColor {
        switch self {
        case .normal: return UIColor(hexCode: "F5F5F5")
        case .main: return UIColor(hexCode: "006FF2")
        }
    }
}

enum StrokeColor {
    case main, sub
    
    var color: UIColor {
        switch self {
        case .main: return UIColor(hexCode: "DFDFDF")
        case .sub: return UIColor(hexCode: "A0A0A0")
        }
    }
}

enum BackgroundColor {
    case white, gray, dark
    
    var color: UIColor {
        switch self {
        case .white: return UIColor(hexCode: "F5F5F5")
        case .gray: return UIColor(hexCode: "F9F9F9")
        case .dark: return UIColor(hexCode: "DADADA")
        }
    }
}
