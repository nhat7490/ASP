//
//  HorizontalView.swift
//  Roommate
//
//  Created by TrinhHC on 10/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol HorizontalRoomViewDelegate:class{
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,collectionCell cell:NewRoomCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndexPath indexPath:IndexPath?)
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,collectionCell cell:NewRoomCVCell,didSelectCellAt indexPath:IndexPath?)
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,onClickButton button:UIButton)
}
class HorizontalRoomView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,NewRoomCVCellDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionView: BaseHorizontalCollectionView!
    weak var delegate:HorizontalRoomViewDelegate?
    var rooms:[RoomPostResponseModel] = []
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.text = "TITLE_SUGGEST_ROOM".localized
        lblTitle.font = .boldMedium
        lblTitle.textColor = .red
        
        btnViewAll.setTitle("TITLE_VIEW_ALL".localized, for: .normal)
        btnViewAll.setTitleColor(.white, for: .normal)
        btnViewAll.backgroundColor = .defaultBlue
        btnViewAll.layer.cornerRadius = 15
        btnViewAll.clipsToBounds = true
        
        
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMCV)
        collectionView.delegate = self
        collectionView.dataSource = self
        layoutSubviews()
    }
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMCV, for: indexPath) as! NewRoomCVCell
        cell.delegate  = self
        cell.room = rooms[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(frame.width/2)
        return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_NEWROOMCV)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NewRoomCVCell
        delegate?.horizontalRoomViewDelegate(horizontalRoomView: self, collectionCell: cell, didSelectCellAt: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //space dif line but here is same line because horizontal scroll
        return 10
    }
    
    //MARK: NewRoomCVCellDelegate
    func newRoomCVCellDelegate(roomCVCell cell:NewRoomCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?){
        delegate?.horizontalRoomViewDelegate(horizontalRoomView: self, collectionCell: cell, onClickUIImageView: imgvBookmark, atIndexPath: indexPath)
    }
    
    @IBAction func onClickBtnViewAll(_ sender: UIButton) {
        delegate?.horizontalRoomViewDelegate(horizontalRoomView: self, onClickButton: sender)
    }
}
