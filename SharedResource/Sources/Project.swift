import Foundation
import SwiftUI

public enum SharedFont { }

public extension SharedFont {
    static func bigJohnPRO(size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .bold:
            return SharedResourceFontFamily.BigJohnPRO.bold.swiftUIFont(size: size)
        case .regular:
            return SharedResourceFontFamily.BigJohnPRO.regular.swiftUIFont(size: size)
        case .light:
            return SharedResourceFontFamily.BigJohnPRO.light.swiftUIFont(size: size)
        default:
            return SharedResourceFontFamily.BigJohnPRO.regular.swiftUIFont(size: size)
        }
    }
}
