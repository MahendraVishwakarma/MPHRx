//
//  ViewController.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 12/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    var searchController : UISearchController!
    var photosInfo : Photos!
    var photos = Array<Photo>()
    var photoLayout : PhotoLayouts = .three
    var isFetched = true
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var footerLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var mainLoader: UIActivityIndicatorView!
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initialSetup()
        
    }
    @IBAction func changeLayout(_ sender: Any) {
        
        let alert = UIAlertController(title: "Layouts", message: "you can choose following layout format", preferredStyle: .actionSheet)
        
        let actionTwo = UIAlertAction(title: "🏞 🏞 Layout", style: .default) { (alt) in
            self.photoLayout = .two
            self.collectionview.reloadData()
        }
        
        let actionThree = UIAlertAction(title: "🏞 🏞 🏞 Layout", style: .default) { (alt) in
            self.photoLayout = .three
            self.collectionview.reloadData()
        }
        
        let actionFour = UIAlertAction(title: "🏞 🏞 🏞 🏞 Layout", style: .default) { (alt) in
            self.photoLayout = .four
            self.collectionview.reloadData()
        }
        
        let actinCancel = UIAlertAction(title: "Cancel", style: .cancel) { (alt) in
            
        }
        
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        alert.addAction(actionFour)
        alert.addAction(actinCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

