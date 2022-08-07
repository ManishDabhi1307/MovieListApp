//
//  Nibloadable.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentity: String { get }
}

extension ReusableView where Self: UIView {
    public static var reuseIdentity: String {
        return "\(self)"
    }
}

public protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

public extension NibLoadableView {
    static var nibName: String {
        return "\(self)"
    }
}

public extension NibLoadableView where Self: UIView {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed(Self.nibName, owner: nil, options: nil)?.first as! Self
    }
}

public extension NibLoadableView where Self: UIToolbar {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed(Self.nibName, owner: nil, options: nil)?.first as! Self
    }
}

public extension NibLoadableView where Self: UIViewController {

    static func loadFromNib() -> Self {
        return Self(nibName: Self.nibName, bundle: nil)
    }
}

