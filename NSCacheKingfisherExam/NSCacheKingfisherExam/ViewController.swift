//
//  ViewController.swift
//  NSCacheKingfisherExam
//
//  Created by youngjun goo on 2019/10/09.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var downLoadButton: UIButton!
    
    private var counter: Int = 0
    private var url: URL = URL(string: LARGEST_IMAGE_URL)!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
    
    
    @IBAction func downLoadImage(_ sender: UIButton) {
        guard let url = URL(string: "https://images.pexels.com/photos/1470589/pexels-photo-1470589.jpeg?cs=srgb&dl=hd-hd-hd-1470589.jpg&fm=jpg") else { return }
        let processor = DownsamplingImageProcessor(size: imageView.frame.size)
                     >> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        //        imageView.kf.setImage(with: url)
        //        DispatchQueue.global().async {
        //            let image = self.loadImage(from: LARGEST_IMAGE_URL)
        //            DispatchQueue.main.async {
        //                self.imageView.image = image
        //            }
        //        }
        
        //        DispatchQueue.global().async {
        //            guard let url = URL(string: "https://images.pexels.com/photos/1470589/pexels-photo-1470589.jpeg?cs=srgb&dl=hd-hd-hd-1470589.jpg&fm=jpg") else { return }
        //            guard let data = try? Data(contentsOf: url) else { return }
        //            let image = UIImage(data: data)
        //            DispatchQueue.main.async {
        //                self.imageView.kf.base.image = image
        //                // self.imageView.image = image
        //            }
        //        }
        
    }
    
    @IBAction func cancelButtonDidTouch(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.imageView.image = nil
        }
    }
    
    private func loadImage(from imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
    
    
}

