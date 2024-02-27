//
//  CustomTextfields.swift
//  smart to do
//
//  Created by Asif Reddot on 22/2/24.
//

import Foundation
import UIKit

public class LoginEmailTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color009B3E
        self.textAlignment = .left
        self.tintColor = CustomColors().color009B3E
        self.keyboardType = .emailAddress
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter email",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color009B3E,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class DashboardSearchTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().colorFFFFFF
        self.textAlignment = .left
        self.tintColor = CustomColors().colorFFFFFF
        self.keyboardType = .emailAddress
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().colorFFFFFF,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class SignupEmailTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.keyboardType = .emailAddress
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter email",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class SignupNameTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.keyboardType = .asciiCapable
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter email",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class CreateTaskTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.borderColor = CustomColors().colorCACFF4
        self.borderWidth = 1
        self.cornerRadius = 9
        self.keyboardType = .asciiCapable
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter task name",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class SignupPhoneTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.keyboardType = .phonePad
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter phone",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class LoginPasswordTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .white
        self.textColor = CustomColors().color009B3E
        self.textAlignment = .left
        self.tintColor = CustomColors().color009B3E
        self.keyboardType = .asciiCapable
        self.isSecureTextEntry = true
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color009B3E,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class SignupPasswordTextField: UITextField {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.keyboardType = .asciiCapable
        self.isSecureTextEntry = true
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 50)).isActive = true
        self.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize)) ?? UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public class TaskDescriptionTextView: UITextView {
    let fontSize: CGFloat = FontSize.size14.rawValue
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clear
        self.textColor = CustomColors().color061053
        self.textAlignment = .left
        self.tintColor = CustomColors().color061053
        self.borderColor = CustomColors().colorCACFF4
        self.borderWidth = 1
        self.cornerRadius = 9
        self.keyboardType = .asciiCapable
        self.font =  UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.heightAnchor.constraint(equalToConstant: getTextFieldHeightWithRespectToDevice(height: 245)).isActive = true
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }
}
