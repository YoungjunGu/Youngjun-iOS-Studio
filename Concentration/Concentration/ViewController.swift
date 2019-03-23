//
//  ViewController.swift
//  Concentration
//
//  Created by youngjun goo on 15/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: -
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flipLabel: UILabel!
    
    var emojisCard = ["👻","🍎","❤️","🙈","👻","🍎","❤️","🙈","👽","👾","👽","👾"]
    var selectCard: String = ""
    
    var flipCount = 0 {
        didSet {
            flipLabel.text = "Flip: \(flipCount)"
        }
    }
    
    @IBAction func touchUpCard(_ sender: UIButton) {
        flipCount += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojisCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! CardCollectionViewCell
        
        cell.cardButton.setTitle(emojisCard[indexPath.row], for: .normal)
        return cell
    }
    
    
}


