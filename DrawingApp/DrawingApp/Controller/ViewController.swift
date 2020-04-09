//
//  ViewController.swift
//  DrawingApp
//
//  Created by youngjun goo on 08/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingView: Canvas!
    @IBOutlet weak var shareTapBarItem: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    let redoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Redo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleRedo), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        drawingView.undo()
    }
    
    @objc fileprivate func handleRedo() {
        drawingView.redo()
    }
    
    @objc fileprivate func handleClear() {
        drawingView.clear()
    }
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColor(button: UIButton) {
        drawingView.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleChangeSlider), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleChangeSlider() {
        drawingView.setStrokeLineWidth(width: slider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingLayout()
    }
    
    fileprivate func settingLayout() {

        let colorStackView = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        //stackView 사이의 간격 일정하게
        colorStackView.distribution = .fillEqually
        
        //stackView를 Storyboard 에서 설정안해주고 코드로 설정하는 방법
        let stackView = UIStackView(arrangedSubviews: [undoButton, redoButton, clearButton,colorStackView, slider])
        //stackView 사이의 간격 일정하게
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        //뷰의 자동 크기 지정 마스크가 자동 레이아웃 제약 조건으로 변환되는지 여부를 결정하는 불 값 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //뷰의 프레임의 리딩 엣지를 나타내는 레이아웃 엥커
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    
    }
    

    @available(iOS 13.0, *)
    @IBAction func shareItemTapped(_ sender: UIBarButtonItem) {
        var image: UIImage?
        var screenImages = [UIImage]()
        var url = URL(string: "")
        var string = ""
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let screenImage = image else { return }
        screenImages.append(screenImage)
        
        // 공유하기 activity
        let shareScreen = UIActivityViewController(activityItems: [screenImages, string, url], applicationActivities: nil)
        let popoverPresentationController = shareScreen.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .any
        present(shareScreen, animated: true, completion: nil)
    }
}

