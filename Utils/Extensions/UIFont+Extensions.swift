import UIKit

extension UIFont {
    static func theme(_ font: JesflixFont) -> UIFont {
        switch font {
        case .regular10:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 10), size: 10)
            
        case .regular12:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 12), size: 12)
            
        case .regular14:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 14), size: 14)
            
        case .regular16:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 16), size: 16)
            
        case .regular18:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 18), size: 18)
            
        case .regular22:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 22), size: 22)
            
        case .regular24:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Regular", size: 24), size: 24)
            
        case .bold10:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 10), size: 10)
            
        case .bold12:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 12), size: 12)
            
        case .bold14:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 14), size: 14)
            
        case .bold16:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 16), size: 16)
            
        case .bold18:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 18), size: 18)
            
        case .bold22:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 22), size: 22)
            
        case .bold24:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 24), size: 24)
            
        case .bold30:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 30), size: 30)
            
        case .italic10:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 10), size: 10)
            
        case .italic12:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 12), size: 12)
            
        case .italic14:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 14), size: 14)
            
        case .italic16:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 16), size: 16)
            
        case .italic18:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 18), size: 18)
            
        case .italic22:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 22), size: 22)
            
        case .italic24:
            return UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Italic", size: 24), size: 24)
        }
    }
}
