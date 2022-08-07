//
//  UITableView+Extension.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import UIKit

public extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type, in bundle: Bundle? = nil) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentity)
    }
    
    func registerView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentity)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentity) as? T else {
            debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            return UITableViewCell() as! T
        }
        return cell
    }
    
    func dequeueReusableView<T: UITableViewHeaderFooterView>(_: T.Type) -> T where T: ReusableView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentity) as? T else {
            debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            return UIView() as! T
        }
        return view
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentity, for: indexPath) as? T else {
            debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            return UITableViewCell() as! T
        }
        
        return cell
    }
    
    func addEmptyFooterView() {
        tableFooterView = UIView()
    }
    
    func setUpAutoRowHeight(withEstimatedRowHeight estimatedRowHeight: CGFloat) {
        rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimatedRowHeight
    }
    
    func setUpAutoFooterHeight(withEstimatedFooterHeight estimatedFooterHeight: CGFloat) {
        sectionFooterHeight = UITableView.automaticDimension
        self.estimatedSectionFooterHeight = sectionFooterHeight
    }
    
    func setUpAutoHeaderHeight(withEstimatedHeaderHeight estimatedHeaderHeight: CGFloat) {
        sectionHeaderHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = sectionHeaderHeight
    }
    
    func sectionHeaderTopPadding() {
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
    
    func removeHeaderFooterBackgroundColor() {
        self.tableHeaderView?.backgroundColor = .clear
        self.tableFooterView?.backgroundColor = .clear
    }
}


