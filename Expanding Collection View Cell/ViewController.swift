//
//  ViewController.swift
//  Expanding Collection View Cell
//
//  Created by Tom Bastable on 06/02/2020.
//  Copyright © 2020 Tom Bastable. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var expandingCell: ExpandingCell!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "demoCell", for: indexPath) as! DemoCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! DemoCollectionViewCell
        let origin = collectionView.convert(cell.frame.origin, to: self.view)
        expandingCell.expandView(origin: origin)
    }

    @IBAction func closeExpanded(_ sender: Any) {
        
        expandingCell.shrinkCell()
        
    }
    
}

