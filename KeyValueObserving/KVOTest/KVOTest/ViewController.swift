//
//  ViewController.swift
//  KVOTest
//
//  Created by youngjun goo on 24/05/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var observations:[NSKeyValueObservation] = []
    let timeManager = TimeManager(Time(stopWatch: Date()))
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    

    
    @IBAction func tapStopButton(_ sender: UIButton) {
        // 현재 시간값 넣어주기
        timeManager.stopTheWatch()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpObserver()
    }
    
    func setUpObserver() {
        let dateObservation = timeManager.time.observe(\.stopWatch, options: [.initial, .new]) { (observed, changed) in
            print("Stop the Watch!! Current time is \(String(describing: changed.newValue))")
            if let newTime = changed.newValue {
                // timeManager.stopWatch 의 변수와 같지만 새롭게 변경되어 감지가된 newValue를 통해 Label의 값을 변경
                self.timeLabel.text = self.timeManager.dateFormatter.string(from: newTime)
            }
        }
        observations.append(dateObservation)
    }
    
    deinit {
        observations.removeAll()
    }
    
}

