//
//  ContentViewController.swift
//  PageViewController
//
//  Created by youngjun goo on 2020/04/09.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    var color: UIColor?
    var index = 0

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    /// 버튼의 레이아웃 지정
    func makeButtonConstraint() {
        self.button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func loadView() {
        let view = UIView()
        guard let color = self.color else {
            view.backgroundColor = .white
            return
        }

        view.backgroundColor = color
        self.view = view
    }

    override func viewDidLoad() {
        view.addSubview(self.button)
        self.button.setTitle(String(self.index), for: .normal)
        self.makeButtonConstraint()
    }

    override func viewWillAppear(_: Bool) {
        self.parent?.view.backgroundColor = self.color
    }
}

