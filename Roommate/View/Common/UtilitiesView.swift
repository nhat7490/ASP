//
//  RoomUtilities.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
protocol UtilitiesViewDelegate:class{
    func utilitiesViewDelegate(utilitiesView view:UtilitiesView, didSelectUtilityAt indexPath:IndexPath)
}
class UtilitiesView : UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: BaseVerticalCollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    var utilities:[UtilityModel]?{
        didSet{
            collectionView.isUserInteractionEnabled = true
            collectionView.delegate = self
            collectionView.dataSource = self
            self.collectionView.reloadData()
        }
    }
    
    weak var delegate:UtilitiesViewDelegate?
    
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
        collectionView.register(UINib(nibName: Constants.CELL_NEWUTILITYCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWUTILITYCV)
        collectionView.allowsSelection = true
        lblTitle.text = "UTILITY_TITLE".localized
        lblTitle.font = .smallTitle
        layoutIfNeeded()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return utilities?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWUTILITYCV, for: indexPath) as! NewUtilityCVCell
        cell.data = utilities![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let utilityForSC = self.utilityForSC else {
            return
        }
        switch utilityForSC {
        case .showDetail:
            delegate?.utilitiesViewDelegate(utilitiesView: self, didSelectUtilityAt: indexPath)
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Size Of cell \(collectionView.frame.width/4)")
        return CGSize(width: collectionView.frame.width/2-13, height:CGFloat(Constants.HEIGHT_CELL_NEW_UTILITY-5))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
