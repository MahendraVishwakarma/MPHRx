//
//  ImageZoomer.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 13/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class ImageZoomer: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let xibName = "ImageZoomer"
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var collectinview: UICollectionView!
    var photos = Array<Photo>()
    var selectedID : String!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialization()
    }
    
    func setSelectedIndex() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            guard let index = self.photos.lastIndex(where: {$0.id == self.selectedID}) else{
                return
            }
            print(index)
            let indecPath = IndexPath(row: index, section: 0)
            self.collectinview.scrollToItem(at: indecPath, at: .centeredHorizontally, animated: false)
        }
        
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func initialization() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        containerView.setFrameInView(self)
        collectinview.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "itemCell")
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell else {
            return ItemCell()
        }
        
        cell.setupData(post: self.photos[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size =  UIScreen.main.bounds.width - 30/2
        return CGSize(width: size, height: size)
        
    }
}
