//
//  BaseViewController.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 06/08/22.
//

import UIKit

//MARK: - BaseViewControllerProtocol
protocol BaseViewControllerProtocol: AnyObject {
    func showError(error: String)
}

//MARK: - BaseViewController
class BaseViewController: UIViewController {
    // MARK: - Variables
    private let loadingView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    private var activityView = UIActivityIndicatorView()
    
    // MARK: - initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpUI() {
        view.addSubview(loadingView)
        setupActivityIndicator()
        hideLoadingView()
    }
    
    func setupActivityIndicator() {
        activityView.style = .large
        activityView.center = loadingView.center
        loadingView.addSubview(activityView)
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
        activityView.stopAnimating()
    }

    func showLoadingView() {
        loadingView.isHidden = false
        activityView.startAnimating()
    }
}

// MARK: - BaseViewControllerProtocol
extension BaseViewController: BaseViewControllerProtocol {
    // MARK: - Actions
    func showError(error: String) {
        let alert = UIAlertController(title: MessageConstants.errorMessageOops, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: MessageConstants.errorMessageOkay, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
