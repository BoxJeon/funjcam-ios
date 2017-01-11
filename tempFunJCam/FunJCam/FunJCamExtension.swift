//
//  FunJCamExtension.swift
//  FunJCam
//
//  Created by boxjeon on 2017. 1. 12..
//  Copyright © 2017년 the42apps. All rights reserved.
//

import Alamofire
import AlamofireImage

extension String {
    
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var length: Int {
        return self.characters.count
    }
    
}

extension UIColor {
    
    convenience init(hex: String?, alpha: CGFloat = 1.0) {
        guard let string = hex, string.hasPrefix("#"), string.length == 7 else {
            assertionFailure("Wrong color: \(hex)")
        }
        var rgb: UInt32 = 0
        let scanner = Scanner(string: string)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgb)
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: alpha)
    }
    
}

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(type: T.Type) {
        self.register(UINib(nibName: type.id, bundle: nil), forCellWithReuseIdentifier: type.id)
    }
    
}

extension UIImageView {
    
    func setImage(url: String?, placeholder: UIImage?, completion: ((UIImage?) -> Void)?) {
        self.image = placeholder
        guard let url = url, url.trimmed.length > 0 else {
            return
        }
        self.af_setImage(withURL: URL(string: url)!, placeholderImage: placeholder, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { (response) in
            if let image = response.result.value {
                completion?(image)
            } else {
                Log.d("Load image fail. from \(url)")
                completion?(nil)
            }
        }
    }
    
}

extension UITableView {
    
    func registerNib<T: UITableViewCell>(type: T.Type) {
        self.register(UINib(nibName: type.id, bundle: nil), forCellReuseIdentifier: type.id)
    }
    
}

extension UIView {
    
    class var id: String { return NSStringFromClass(self).components(separatedBy: ".").last! }
    
}

extension UIViewController {
    
    class var id: String { return NSStringFromClass(self).components(separatedBy: ".").last! }
    
    class func create(storyboardName: String) -> UIViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.id)
    }
    
}