import Orion
import BatterainC
import UIKit
import os

@objc protocol _UIBatteryViewPrivate {
    var chargePercent: CGFloat { get }
}

class _UIBatteryViewHook: ClassHook<UIView> {
    static var targetName: String = "_UIBatteryView"
    
    func fillColor() -> UIColor {
        return color()
    }
    func _batteryFillColor() -> UIColor {
        return color()
    }
    func boltColor() -> UIColor {
        return .green
    }
    
    // Private function are just helper function. The above ones are overrides.
    private func color() -> UIColor {
        let percentage = percentage()
        if percentage <= 0.4 {
            return UIColor.red.toColor(.yellow, percentage: percentage * 2)
        } else {
            return UIColor.yellow.toColor(.green, percentage: (percentage - 0.4) / 0.6) // 0.6 comes from 1 - 0.4
        }
    }
    private func percentage() -> Double {
        let converted = target.as(interface: _UIBatteryViewPrivate.self)
        
        return converted.chargePercent
    }
}



extension UIColor {
    func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 100), 0)
        switch percentage {
        case 0: return self
        case 1: return color
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
            guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }

            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
}


//func logt(_ string: StaticString) {
//    let log = OSLog.init(subsystem: "ovh.exerhythm.batterain", category: "main")
//    os_log(string, log: log)
//}
