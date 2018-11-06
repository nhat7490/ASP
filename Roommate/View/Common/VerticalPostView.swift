//
//  VerticalPostView.swift
//  Roommate
//
//  Created by TrinhHC on 10/23/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol VerticalPostViewDelegate:class {
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,collectionCell cell: UICollectionViewCell, onClickUIImageView: UIImageView, atIndexPath indexPath: IndexPath?)
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,collectionCell cell: UICollectionViewCell, didSelectCellAt indexPath: IndexPath?)
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,onClickButton button:UIButton)
}
extension VerticalPostViewDelegate{
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,collectionCell cell: UICollectionViewCell, onClickUIImageView: UIImageView, atIndexPath indexPath: IndexPath?){}
}
class VerticalPostView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,NewRoomCVCellDelegate,UICollectionViewDelegateFlowLayout,NewRoommateCVCellDelegate{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionView: BaseVerticalCollectionView!
    
    @IBOutlet weak var btnViewAllHeightConstraint: NSLayoutConstraint!
    weak var delegate:VerticalPostViewDelegate?
    var verticalPostViewType:VerticalPostViewType?{
        didSet{
            if verticalPostViewType == .room{
                lblTitle.text = "TITLE_NEW_ROOM".localized
            }else if verticalPostViewType == .roommate{
                lblTitle.text = "TITLE_NEW_ROOMMATE".localized
            }else if verticalPostViewType == .roomOwner{
                lblTitle.text = "TITLE_CREATED_ROOM".localized
            }
        }
    }

    var rooms:[RoomPostResponseModel] = []
    {
        didSet{
            collectionView.reloadData()
        }
    }
    var roommates:[RoommatePostResponseModel] = []
    {
        didSet{
            collectionView.reloadData()
        }
    }
    var roomsOwner:[RoomResponseModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .boldMedium
        lblTitle.textColor = .red
        btnViewAll.setTitle("TITLE_VIEW_ALL".localized, for: .normal)
        
        btnViewAll.setTitleColor(.white, for: .normal)
        btnViewAll.backgroundColor = .defaultBlue
        btnViewAll.layer.cornerRadius = 15
        btnViewAll.clipsToBounds = true
        
        collectionView.register(UINib(nibName: Constants.CELL_ROOMPOSTCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMPOSTCV)
        collectionView.register(UINib(nibName: Constants.CELL_ROOMMATEPOSTCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMMATEPOSTCV)
        collectionView.register(UINib(nibName: Constants.CELL_ROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMCV)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        
    }
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if verticalPostViewType == .room{
            return rooms.count
        }else if verticalPostViewType == .roommate{
            return roommates.count
        }else{
            return roomsOwner.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if verticalPostViewType == .room{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMPOSTCV, for: indexPath) as! RoomPostCVCell
            cell.delegate  = self
            cell.room = rooms[indexPath.row]
            cell.indexPath = indexPath
            return cell
        }else if verticalPostViewType == .roommate{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATEPOSTCV, for: indexPath) as! RoommatePostCVCell
            cell.delegate  = self
            cell.roommate = roommates[indexPath.row]
            cell.indexPath = indexPath
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMCV, for: indexPath) as! RoomCVCell
            cell.room = roomsOwner[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if verticalPostViewType == .room{
            return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_ROOMPOSTCV)
        }else if verticalPostViewType == .roommate{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_ROOMMATEPOSTCV)
        }else{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_ROOMFOROWNERCV)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if verticalPostViewType == .room{
            let cell = collectionView.cellForItem(at: indexPath) as! RoomPostCVCell
            delegate?.verticalPostViewDelegate(verticalPostView:self,collectionCell: cell, didSelectCellAt: indexPath)
        }else if verticalPostViewType == .roommate{
            let cell = collectionView.cellForItem(at: indexPath) as! RoommatePostCVCell
            delegate?.verticalPostViewDelegate(verticalPostView:self,collectionCell: cell, didSelectCellAt: indexPath)
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! RoomCVCell
            delegate?.verticalPostViewDelegate(verticalPostView:self,collectionCell: cell, didSelectCellAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //dif row
        return 0
    }
    
    //MARK: NewRoomCVCellDelegate
    func newRoomCVCellDelegate(roomCVCell cell:RoomPostCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?){
        delegate?.verticalPostViewDelegate(verticalPostView:self,collectionCell: cell, onClickUIImageView: imgvBookmark, atIndexPath: indexPath)
    }
    //MARK: NewRoommateCVCellDelegate
    func newRoommateCVCellDelegate(newRoommateCVCell cell: RoommatePostCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
        delegate?.verticalPostViewDelegate(verticalPostView:self,collectionCell: cell, onClickUIImageView: imgvBookmark, atIndexPath: indexPath)
    }
    @IBAction func onClickBtnViewAll(_ sender: UIButton) {
        delegate?.verticalPostViewDelegate(verticalPostView:self,onClickButton: sender)
    }
    
    //MARK: Others
    func hidebtnViewAllButton(){
        btnViewAllHeightConstraint.constant = 0
//        btnViewAll.translatesAutoresizingMaskIntoConstraints  = false
//        btnViewAll.heightAnchor.constraint(equalToConstant: 0).isActive = true
        layoutSubviews()
    }
    func showbtnViewAllButton(){
//        btnViewAll.translatesAutoresizingMaskIntoConstraints  = false
//        btnViewAll.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnViewAllHeightConstraint.constant = 40
        layoutSubviews()
    }
}
