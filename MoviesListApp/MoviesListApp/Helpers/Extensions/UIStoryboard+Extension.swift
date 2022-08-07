//
//  UIStoryboard+Extension.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import UIKit

enum Storyboard: String {
    case Main
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(withViewClass: T.Type) -> T {
        return storyboard.instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
}
