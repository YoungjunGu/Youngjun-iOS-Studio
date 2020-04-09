//
//  ViewController.swift
//  PageViewController
//
//  Created by youngjun goo on 2020/04/09.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    var mainPageViewController: UIPageViewController?
    var colorList: [UIColor] = [UIColor.blue, UIColor.brown, UIColor.yellow]
    var currentIndex = 0
    /// 뷰를 추가한다.
    @IBAction func addView(_ sender: UIBarButtonItem) {
        self.colorList.insert(UIColor.red, at: 0)

        if let startIngViewController = makeContentViewController(index: 0) {
            self.mainPageViewController!.setViewControllers([startIngViewController], direction: .reverse, animated: true, completion: nil)
        }
    }

    @IBAction func removeView(_ sender: UIBarButtonItem) {
        if self.colorList.count > 1 {
            self.currentIndex = 0
            self.colorList.remove(at: self.currentIndex)
            if let startIngViewController = makeContentViewController(index: 0) {
                self.mainPageViewController!.setViewControllers([startIngViewController], direction: .reverse, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: nil, message: "최소 하나의 뷰는 존재해야하므로 \n 더 이상 삭제할 수 없습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            self.present(alert,animated: true)
        }
    }

    /// ContentViewController를 만든다.
    ///
    /// - Parameter index: 만들어질 ContentViewController의 인덱스를 넘겨받는다.
    /// - Returns: 만들어진 ContentViewController를 반환한다.
    func makeContentViewController(index: Int) -> ContentViewController? {
        // index가 총 갯수보다 크면 nil을 반환한다.
        if index > self.colorList.count {
            return nil
        }

        let pageContentViewController = ContentViewController()
        pageContentViewController.color = self.colorList[index]
        pageContentViewController.index = index

        return pageContentViewController
    }
    /// PageController를 만들고 기본 상태를 셋팅한다.
    func makeDefaultPageViewController() {
        let mainPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        mainPageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

        self.mainPageViewController = mainPageViewController

        if let startIngViewController = makeContentViewController(index: 0), let unWrappingPageViewController = self.mainPageViewController {
            let viewControllers = [startIngViewController]
            unWrappingPageViewController.setViewControllers(viewControllers, direction: .reverse, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        self.colorList.reverse()
        self.makeDefaultPageViewController()

        guard let mainPageViewController = self.mainPageViewController else {
            return
        }

        view.addSubview(mainPageViewController.view)
        addChild(mainPageViewController)
        mainPageViewController.didMove(toParent: self)
        mainPageViewController.dataSource = self
        mainPageViewController.delegate = self
    }
}

// MARK: - Extension

extension MainPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else {
            return nil
        }

        var previousIndex = targetViewController.index

        if previousIndex == 0 {
            previousIndex = self.colorList.count - 1
        } else {
            previousIndex -= 1
        }

        return self.makeContentViewController(index: previousIndex)
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else {
            return nil
        }

        var nextIndex = targetViewController.index

        if nextIndex == self.colorList.count - 1 {
            nextIndex = 0
        } else {
            nextIndex += 1
        }

        return self.makeContentViewController(index: nextIndex)
    }

    // 인디케이터의 개수
    func presentationCount(for _: UIPageViewController) -> Int {
        return self.colorList.count
    }

    // 인디케이터의 초기 값
    func presentationIndex(for _: UIPageViewController) -> Int {
        return 0
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?[0] as? ContentViewController {
                self.currentIndex = currentViewController.index
            }
        }
    }
}

