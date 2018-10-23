//
//  VerticalPostView.swift
//  Roommate
//
//  Created by TrinhHC on 10/23/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol VerticalPostViewDelegate:class {
    func verticalPostViewDelegate(roomCVCell cell: NewRoomCVCell, onClickUIImageView: UIImageView, atIndextPath: IndexPath?)
    func verticalPostViewDelegate(roommateCVCell cell: NewRoommateCVCell, onClickUIImageView: UIImageView, atIndextPath: IndexPath?)
    func verticalPostViewDelegate(onClickButton button:UIButton)
}
class VerticalPostView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,NewRoomCVCellDelegate,UICollectionViewDelegateFlowLayout,NewRoommateCVCellDelegate{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionView: BaseVerticalCollectionView!
    
    weak var delegate:VerticalPostViewDelegate?
    var verticalPostViewType:VerticalPostViewType?{
        didSet{
            if verticalPostViewType == .room{
                lblTitle.text = "TITLE_NEW_ROOM".localized
            }else{
                lblTitle.text = "TITLE_NEW_ROOMMATE".localized
            }
        }
    }
    
    var rooms:[RoomPostResponseModel] = []
    var roommates:[RoommatePostResponseModel] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .boldSmall
        lblTitle.textColor = .red
        btnViewAll.setTitle("TITLE_VIEW_ALL".localized, for: .normal)
        
        btnViewAll.setTitleColor(.white, for: .normal)
        btnViewAll.backgroundColor = .defaultBlue
        btnViewAll.layer.cornerRadius = 15
        btnViewAll.clipsToBounds = true
        
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMCV)
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMMATECV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMMATECV)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        
        
        
        
    }
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if verticalPostViewType == VerticalPostViewType.room{
            return rooms.count
        }else{
            return roommates.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if verticalPostViewType == .room{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMCV, for: indexPath) as! NewRoomCVCell
            cell.delegate  = self
            cell.room = rooms[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMMATECV, for: indexPath) as! NewRoommateCVCell
            cell.delegate  = self
            cell.roommate = roommates[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if verticalPostViewType == .room{
            return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_NEWROOMCV.cgFloat)
        }else{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_NEWROOMMATECV.cgFloat)
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //dif row
        return 0
    }
    
    //MARK: NewRoomCVCellDelegate
    func newRoomCVCellDelegate(roomCVCell cell:NewRoomCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?){
        delegate?.verticalPostViewDelegate(roomCVCell: cell, onClickUIImageView: imgvBookmark, atIndextPath: indexPath)
    }
    //MARK: NewRoommateCVCellDelegate
    func newRoommateCVCellDelegate(newRoommateCVCell cell: NewRoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
        delegate?.verticalPostViewDelegate(roommateCVCell: cell, onClickUIImageView: imgvBookmark, atIndextPath: indexPath)
    }
    @IBAction func onClickBtnViewAll(_ sender: UIButton) {
        delegate?.verticalPostViewDelegate(onClickButton: sender)
    }
    
}
