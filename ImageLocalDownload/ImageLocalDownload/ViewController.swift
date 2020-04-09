//
//  ViewController.swift
//  ImageLocalDownload
//
//  Created by youngjun goo on 2020/01/16.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {
    
    let url: String = "https://www.researchgate.net/profile/Elif_Bayramoglu/publication/322918596/figure/fig3/AS:669304651530259@1536586072864/Sample-example-of-xeriscape-URL-3.jpg"
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func tappedDownloadBtn(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: self.url))
            
        }
    }
    
    @IBAction func tappedSaveBtn(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
    }
    

}

