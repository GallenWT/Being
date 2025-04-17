//
//  +UIImageResizer.swift
//  Calendar
//
//  Created by Muhammad Rasyad Caesarardhi on 15/07/24.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
