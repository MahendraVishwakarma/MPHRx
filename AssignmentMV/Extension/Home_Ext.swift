//
//  Home_Ext.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 12/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit


extension HomeVC:UISearchBarDelegate {
    
    func initialSetup() {
        
        self.title = "Home"
     
        if #available(iOS 10.0, *) {
            collectionview.refreshControl = refreshControl
        }
        else{
            collectionview.addSubview(refreshControl)
        }
        
        let str = NSAttributedString.init(string: "pull to refresh")
        refreshControl.attributedTitle = str
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(refreshedData), for: .valueChanged)
        
        // searchBar initialization
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "search..."
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // registering cell to collectionView
        collectionview.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "itemCell")
        bottomCons.constant = 0
        footerLoader.stopAnimating()
        
        // fetch server data
        let page_number = photosInfo != nil ? photosInfo.photos.page + 1 : 1
        let url = String(format: URLs.photos, page_number)
        mainLoader.startAnimating()
        fetchData(url: url)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData(keyword: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
       
    }

    func searchData(keyword:String) {
        
       let url = String(format: URLs.search, keyword)
      
        WebServices.requestHttp(urlString:url , method: .Get, decode: { json -> Photos? in
            guard let response = json as? Photos else{
                return nil
            }
            
            return response
        }) {[weak self]  (result) in
            self?.isFetched = true
            DispatchQueue.main.async {
                self?.bottomCons.constant = 0
                self?.footerLoader.stopAnimating()
                self?.refreshControl.endRefreshing()
            }
            
            switch result {
                
            case .failure(let error):
                self?.showToast(message: error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.photosInfo = data
                    self?.photos = data?.photos.photo ?? []
                    self?.collectionview.reloadData()
                }
                
            }
    }
    }
    
    @objc func refreshedData()
    {
        if(isFetched)
        {
            photosInfo = nil
            photos.removeAll()
            self.collectionview.reloadData()
            let page_number = photosInfo != nil ? photosInfo.photos.page + 1 : 1
            let url = String(format: URLs.photos, page_number)
            fetchData(url: url)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let  height = collectionview.frame.size.height
        let contentYoffset = collectionview.contentOffset.y
        let distanceFromBottom = collectionview.contentSize.height - contentYoffset
        if distanceFromBottom <= height && photos.count > 0 {
            
            print("you have reached at end poind")
            bottomCons.constant = 24
            footerLoader.startAnimating()
            if(isFetched) {
                isFetched = false
                let page_number = photosInfo != nil ? photosInfo.photos.page + 1 : 1
                let url = String(format: URLs.photos, page_number)

                fetchData(url: url)
            }
        }
    }
    
    func fetchData(url:String) {
        
        WebServices.requestHttp(urlString:url , method: .Get, decode: { json -> Photos? in
            guard let response = json as? Photos else{
                return nil
            }
            
            return response
        }) {[weak self]  (result) in
            self?.isFetched = true
            DispatchQueue.main.async {
                self?.bottomCons.constant = 0
                self?.footerLoader.stopAnimating()
                self?.refreshControl.endRefreshing()
                self?.mainLoader.stopAnimating()
            }
            
            
            switch result {
            
            case .failure(let error):
                self?.showToast(message: error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.photosInfo = data
                    self?.photos.append(contentsOf: (data?.photos.photo ?? []))
                    self?.collectionview.reloadData()
                }
                
            }
           
        }
    }
}

extension HomeVC:UICollectionViewDataSource {
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
}

extension HomeVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewObject = ImageZoomer(frame: self.view.bounds)
        viewObject.photos = photos
        viewObject.selectedID = photos[indexPath.row].id
        self.view.window?.addSubview(viewObject)
        viewObject.setSelectedIndex()
    }
}

extension HomeVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layoutFormat = Utils.layoutValue(layout: photoLayout)
        let size =  UIScreen.main.bounds.width/CGFloat(layoutFormat) - 30/2
        return CGSize(width: size, height: size)
        
    }
}




