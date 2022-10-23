import Foundation
import UIKit
import SwiftUI

class Theme {
    static func setup(){
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
    }
}
