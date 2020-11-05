//
//  Circuit.swift
//  Boolder
//
//  Created by Nicolas Mondollot on 31/03/2020.
//  Copyright © 2020 Nicolas Mondollot. All rights reserved.
//

import UIKit

class Circuit {
    enum CircuitColor: Int, Comparable {
        case whiteForKids
        case yellow
        case orange
        case blue
        case skyBlue
        case red
        case black
        case white
        case offCircuit
        
        static
        func < (lhs:Self, rhs:Self) -> Bool
        {
            return lhs.rawValue < rhs.rawValue
        }
        
        var uicolor: UIColor {
            switch self {
            case .whiteForKids:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .yellow:
                return #colorLiteral(red: 1, green: 0.8, blue: 0.007843137255, alpha: 1)
            case .orange:
                return #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            case .blue:
                return #colorLiteral(red: 0.003921568627, green: 0.4784313725, blue: 1, alpha: 1)
            case .skyBlue:
                return #colorLiteral(red: 0.3529411765, green: 0.7803921569, blue: 0.9803921569, alpha: 1)
            case .red:
                return #colorLiteral(red: 1, green: 0.231372549, blue: 0.1843137255, alpha: 1)
            case .black:
                return #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
            case .white:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .offCircuit:
                return #colorLiteral(red: 0.6306057572, green: 0.6335269809, blue: 0.6406573653, alpha: 1)
            }
        }
        
        func uicolorForPhotoOverlay() -> UIColor {
            if self == .offCircuit {
                return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            else {
                return uicolor
            }
        }
        
        func shortName() -> String {
            switch self {
            case .yellow:
                return NSLocalizedString("circuit.short_name.yellow", comment: "")
            case .orange:
                return NSLocalizedString("circuit.short_name.orange", comment: "")
            case .blue:
                return NSLocalizedString("circuit.short_name.blue", comment: "")
            case .skyBlue:
                return NSLocalizedString("circuit.short_name.skyblue", comment: "")
            case .red:
                return NSLocalizedString("circuit.short_name.red", comment: "")
            case .white:
                return NSLocalizedString("circuit.short_name.white", comment: "")
            case .whiteForKids:
                return NSLocalizedString("circuit.short_name.white_for_kids", comment: "")
            case .black:
                return NSLocalizedString("circuit.short_name.black", comment: "")
            case .offCircuit:
                return NSLocalizedString("circuit.short_name.off_circuit", comment: "")
            }
        }
        
        func longName() -> String {
            switch self {
            case .yellow:
                return NSLocalizedString("circuit.long_name.yellow", comment: "")
            case .orange:
                return NSLocalizedString("circuit.long_name.orange", comment: "")
            case .blue:
                return NSLocalizedString("circuit.long_name.blue", comment: "")
            case .skyBlue:
                return NSLocalizedString("circuit.long_name.skyblue", comment: "")
            case .red:
                return NSLocalizedString("circuit.long_name.red", comment: "")
            case .white:
                return NSLocalizedString("circuit.long_name.white", comment: "")
            case .whiteForKids:
                return NSLocalizedString("circuit.long_name.white_for_kids", comment: "")
            case .black:
                return NSLocalizedString("circuit.long_name.black", comment: "")
            case .offCircuit:
                return NSLocalizedString("circuit.long_name.off_circuit", comment: "")
            }
        }
    }
    
    init(color: CircuitColor, overlay: CircuitOverlay) {
        self.color = color
        self.overlay = overlay
    }
    
    let color: CircuitColor
    let overlay: CircuitOverlay
    
    static func circuitColorFromString(_ string: String?) -> CircuitColor {
        switch string {
        case "yellow":
            return CircuitColor.yellow
        case "orange":
            return CircuitColor.orange
        case "blue":
            return CircuitColor.blue
        case "skyblue":
            return CircuitColor.skyBlue
        case "red":
            return CircuitColor.red
        case "black":
            return CircuitColor.black
        case "white":
            return CircuitColor.white
        default:
            return CircuitColor.offCircuit
        }
    }
}
