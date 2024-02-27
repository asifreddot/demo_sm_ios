//
//  CustomWindow.swift
//  smart to do
//
//  Created by Asif Reddot on 22/2/24.
//

import UIKit

public class CustomWindow: UIWindow {
    public override func sendEvent(_ event: UIEvent) {
        if event.type == .touches {
            if let touches = event.allTouches {
                for touch in touches {
                    let phase = touch.phase
                    switch phase {
                    case .began:
                        // Handle touch began
                        break
                    case .ended:
                        NotificationCenter.default.post(name: Notification.Name(UtilityConstants.userActivityNotification), object: nil)
                        break
                    default:
                        break
                    }
                }
            }
        }

        super.sendEvent(event)
    }
}
