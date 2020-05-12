//
//  KeyboardWillChange+Handler.swift
//  VitorDecioPedroBruno
//
//  Created by vitor.ferrazvarela on 12/05/20.
//  Copyright © 2020 vitor.ferrazvarela. All rights reserved.
//

import UIKit

public extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
extension UIView {
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curveFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = (targetFrame.origin.y) - curveFrame.origin.y
        let textField = UIResponder.currentFirst() as? UITextField
        let textFieldY: CGFloat = textField?.globalFrame?.origin.y ?? 0.0
        let textFieldHeight: CGFloat = textField?.globalFrame?.height ?? 0.0
        let bottomSpace = self.frame.height - textFieldY - textFieldHeight

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            if deltaY >= 0 {
                self.frame.origin = .zero
            } else {
                let difference = deltaY + bottomSpace
                if difference <= 0 {
                    self.frame.origin.y -= -difference
                }
            }
        }, completion: nil)

    }
}
