//
//  RoomUtilities.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit

class UtilitiesView : UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    var data:[UtilityModel]?{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            self.collectionView.reloadData()
        }
    }
    
    var utilityForSC:UtilityForSC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Init frame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Init Coder")
    }
    
    override func awakeFromNib() {
        print("awakeFromNib")
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceHorizontal =  false
        collectionView.isPagingEnabled = false
        collectionView.setCollectionViewLayout(BaseVerticalCollectionViewFlowLayout(), animated: false)
        collectionView.register(UINib(nibName: Constants.CELL_UTILITYCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_UTILITYCV)
        collectionView.allowsSelection = true
        lblTitle.font = UIFont.systemFont(ofSize: .subtitle)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data==nil ? 0 : data!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_UTILITYCV, for: indexPath) as! UtilityCVCell
        cell.data = data![indexPath.row]
        cell.isSelectedUtility = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.width/4)
        return CGSize(width: collectionView.frame.width/4, height:collectionView.frame.width/10+50)
    }
}
