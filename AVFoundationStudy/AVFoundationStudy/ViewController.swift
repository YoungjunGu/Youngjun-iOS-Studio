//
//  ViewController.swift
//  AVFoundationStudy
//
//  Created by youngjun goo on 19/09/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    func loadValueAsyncByPlayableKey() {
        guard let url = Bundle.main.url(forResource: "Ecstasy?", withExtension: "mp3") else {
            return
        }
        let asset = AVAsset(url: url)
        let playableKey = "playable"
        
        asset.loadValuesAsynchronously(forKeys: [playableKey]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: playableKey, error: &error)
            switch status {
            case .loaded:
                // 성공적으로 데이터를 받아 왔을때
                break
            case .failed:
                // 실패했을 경우
                break
            case .cancelled:
                // 도중에 취소된, 중단된 경우
                break
            default:
                // 기타 다른 경우
                break
                
            }
        }
    }
    
    func loadValueAsyncByFormatsKey() {
        guard let url = Bundle.main.url(forResource: "Ecstasy?", withExtension: "mp3") else {
            return
        }
        let asset = AVAsset(url: url)
        let formatsKey = "availableMetadataFormats"
        
        asset.loadValuesAsynchronously(forKeys: [formatsKey]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: formatsKey, error: &error)
            if status == .loaded {
                // identifier를 배열 행태로 반환 하기 떄문에 for문을 통해 하나씩 metadata에 하나씩 접근해야한다.
                for format in asset.availableMetadataFormats {
                    let metadata = asset.metadata(forFormat: format)
                    
                    
                }
            }
        }
    }
    
    
}

