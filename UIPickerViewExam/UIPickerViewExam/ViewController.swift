//
//  ViewController.swift
//  UIPickerViewExam
//
//  Created by youngjun goo on 28/09/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        
        picker.frame = CGRect(x: 0, y: self.view.bounds.size.height / 3 , width: self.view.bounds.size.width, height: 180.0)
        
        picker.backgroundColor = UIColor.white
        
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }()
    
    // private let pickerView = UIPickerView()
    private var pickerData1: [String] = ["A","B","C","D","E","F","G","H","I"]
    private var pickerData2: [String] = ["a","b","c","d","e","f","g","h","i"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(pickerView)
        
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // pickerView의 열의 개수를 반환한다
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 하나의 Component당 data의 개수를 설정한다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData1.count
    }

    
    // picker가 선택이 되었으면 호출되는 callback method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("row: \(row)")
            print("value: \(pickerData1[row])")
        } else {
            print("row: \(row)")
            print("value: \(pickerData2[row])")
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
//            return pickerData1[row]
//        } else {
//            return pickerData2[row]
//        }
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        // 위에서 설정한 selectedRow의 Component에 따라 컨텐츠르 다르게 보여주는 작업을 한다.
        if component == 0 {
            pickerLabel.text =  "왼쪽" + pickerData1[row]
        } else {
            pickerLabel.text = pickerData2[row] + "오른쪽"
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 20)
        // 중앙 정렬
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    
}

