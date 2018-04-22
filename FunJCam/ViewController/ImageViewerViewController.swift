//
//  ImageViewerViewController.swift
//  funjcam
//
//  Created by boxjeon on 2016. 7. 23..
//  Copyright © 2016년 boxjeon. All rights reserved.
//

import Crashlytics

class ImageViewerViewController: FJViewController, NibLoadable {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    var image: UIImage?
    var searchedImage: SearchedImage?
    
    class func create(image: UIImage?, searchedImage: SearchedImage?) -> Self {
        let viewController = self.create(storyboardName: "Main")!
        viewController.image = image
        viewController.searchedImage = searchedImage
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupImageViewer()
        
        self.setupButtons()
    }
    
    func setupImageViewer() {
        self.imageView.setImage(url: self.searchedImage?.url, placeholder: self.image, completion: { [weak self] (image) -> Void in
            if let url = self?.searchedImage?.url, image == nil {
                Answers.logCustomEvent(withName: "Image Download Failure", customAttributes: ["host": URL(string: url)?.host ?? "unknown"])
            }
        })
    }
    
    func setupButtons() {
        // TODO: Language
        self.closeButton.setTitle("Close", for: .normal)
        self.shareButton.setTitle("Share", for: .normal)
    }
    
    @IBAction func onCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onShareTapped(_ sender: UIButton) {
        if let url = URL(string: self.searchedImage?.url ?? "") {
            do {
                let data = try Data(contentsOf: url)
                let viewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                self.present(viewController, animated: true, completion: nil)
            } catch {
                self.showOkAlert(title: "이미지를 가져오지 못했습니다.", message: nil, onOk: nil)
            }
        } else {
            self.showOkAlert(title: "이미지를 가져오지 못했습니다.", message: nil, onOk: nil)
        }
    }
}
