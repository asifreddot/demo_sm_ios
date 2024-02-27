//
//  CustomButtons.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation
import UIKit

public class LoginButton: UIButton {
    let fontSize: CGFloat = FontSize.size14.rawValue

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = 5
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = CustomColors().color009B3E
        self.heightAnchor.constraint(equalToConstant: getButtonHeightWithRespectToDevice(buttonHeight: 44)).isActive = true
        self.titleLabel?.font = UIFont(name: Fonts.Inter.weight500, size: getFontSizeWithRespectToDevice(minimumFontSize: fontSize))
        self.titleLabel?.textColor = .white
    }
}
