//
//  HorizontalImagesView.swift
//  Roommate
//
//  Created by TrinhHC on 10/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class HorizontalImagesView: UIView , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: BaseHorizontalCollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var images:[String]?{
        didSet{
            pageControl.numberOfPages = images?.count ?? 0
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: Constants.CELL_IMAGECV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_IMAGECV)
        pageControl.pageIndicatorTintColor = .lightSubTitle
        pageControl.currentPage = 0
    }
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_IMAGECV, for: indexPath) as! ImageCVCell
        cell.link_url = images?[indexPath.row]
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: Constants.HEIGHT_CELL_IMAGECV)
    }
    
    //MARK: ScrollViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = Int(targetContentOffset.pointee.x/collectionView.frame.width)
        print(targetContentOffset.pointee)
        print(collectionView.frame.width)
        print(currentPage)
        pageControl.currentPage = currentPage
    }
    func removePageControl(){
        pageControl.removeFromSuperview()
    }
}
