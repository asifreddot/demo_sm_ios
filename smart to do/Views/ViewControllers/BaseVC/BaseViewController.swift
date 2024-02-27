//
//  BaseViewController.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit

open class BaseViewController: UIViewController {
    public var backButtonClick = false

    open override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: Navigation Setup
extension BaseViewController {
    public func navigationUISetup(isBackButtonHidden: Bool, title: String?, titleColor: UIColor = CustomColors().color061053) {
        
        if !isBackButtonHidden {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(clickedOnBack))
            self.navigationItem.leftBarButtonItem?.tintColor = .black
        }
        
        self.navigationItem.setHidesBackButton(isBackButtonHidden, animated:true)
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 1
        let fontSize: CGFloat = FontSize.size16.rawValue
        titleLabel.font = UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        titleLabel.textAlignment = .left
        titleLabel.textColor = titleColor
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.title = title
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @objc open func clickedOnBack() {
        print("Back button pressed")
        backButtonClick = true
        navigationController?.popViewController(animated: true)
    }
}
