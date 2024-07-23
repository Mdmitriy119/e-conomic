//
//  UIImage+NSData.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import UIKit

extension UIImage {
    var asNSData: NSData? {
        guard let data = self.pngData() else { return nil }
        return NSData(data: data)
    }
}
