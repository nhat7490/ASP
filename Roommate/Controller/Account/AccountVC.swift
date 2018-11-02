//
//  AccountVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import MBProgressHUD
class AccountVC:BaseVC,VerticalPostViewDelegate{
    
    
    lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    lazy var contentView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .red
        return v
    }()
    
    lazy var topContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    lazy var bottomContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    
    lazy var horizontalImagesView:HorizontalImagesView = {
        let hv:HorizontalImagesView = .fromNib()
        hv.removePageControl()
        return hv
    }()
    lazy var verticalRoomView:VerticalPostView = {
        let vv:VerticalPostView = .fromNib()
        vv.verticalPostViewType = .roomOwner
        return vv
    }()
    lazy var btnSetting:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "setting"), for: .normal)
        return btn
    }()
    var contentViewHeightConstraint:NSLayoutConstraint?
    var topContainerViewHeight:CGFloat?
    var bottomContainerViewHeightConstraint:NSLayoutConstraint?
    var verticalRoomViewHeightConstraint:NSLayoutConstraint?
    var rooms:[RoomResponseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegateAndDataSource()
        loadRemoteData()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "filter"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClickBtnSetting))
        navigationItem.rightBarButtonItem?.tintColor = .defaultBlue
        
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        let verticalRoomViewHeight:CGFloat = 80.0
        topContainerViewHeight = Constants.HEIGHT_CELL_IMAGECV
        let bottomContainerViewHeight:CGFloat = verticalRoomViewHeight
        let totalContentViewHeight:CGFloat = topContainerViewHeight! + bottomContainerViewHeight
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainerView)
        topContainerView.addSubview(horizontalImagesView)
        topContainerView.addSubview(btnSetting)
        contentView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(verticalRoomView)
        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        } else {
            // Fallback on earlier versions
            _ = scrollView.anchor(topLayoutGuide.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        }
        
        _ = contentView.anchor(scrollView.topAnchor, scrollView.leftAnchor, scrollView.bottomAnchor, scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        contentViewHeightConstraint = contentView.anchorHeight(equalToConstrant:totalContentViewHeight)
        
        _ = topContainerView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: topContainerViewHeight!))
        bottomContainerViewHeightConstraint = bottomContainerView.anchor(topContainerView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: bottomContainerViewHeight))[3]
        
        _ = horizontalImagesView.anchor(topContainerView.topAnchor, topContainerView.leftAnchor, topContainerView.bottomAnchor, topContainerView.rightAnchor)
        _ = btnSetting.anchor(topContainerView.topAnchor, nil, nil, topContainerView.rightAnchor,UIEdgeInsets(top: Constants.MARGIN_10, left: 0, bottom: 0, right: -Constants.MARGIN_10),CGSize(width: 24, height: 24))
        
        verticalRoomViewHeightConstraint = verticalRoomView.anchor(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: verticalRoomViewHeight))[3]
        
        verticalRoomView.hidebtnViewAllButton()
        
    }
    func setupDelegateAndDataSource(){
        horizontalImagesView.images = [DBManager.shared.getUser()!.imageProfile!]
        verticalRoomView.delegate = self
        btnSetting.addTarget(self, action: #selector(onClickBtnSetting), for: .touchUpInside)
    }
    func loadRemoteData(){
        requestRoom(view: verticalRoomView.collectionView, apiRouter: APIRouter.getRoomsByUserId(userId: DBManager.shared.getUser()!.userId, page: 1, offset: 15))
    }
    func  requestRoom(view:UICollectionView,apiRouter:APIRouter){
        //        roomFilter.searchRequestModel = nil
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.verticalRoomView.collectionView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
        }
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter, returnType:RoomResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: view, animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoom(view: view, apiRouter: apiRouter)
                        })
                    }
                }else{
                    //200
                    if statusCode == .OK{
                        guard let values = values else{
                            return
                        }
                        if values.count == 0{
                            self.showNoDataView(inView:self.verticalRoomView.collectionView, withTitle: "NO_OWNER_ROOM".localized)
                        }else{
                            self.rooms = values
                            self.verticalRoomViewHeightConstraint?.constant = Constants.HEIGHT_CELL_ROOMFOROWNERCV*CGFloat(values.count) + 80.0
                            self.bottomContainerViewHeightConstraint?.constant = self.verticalRoomViewHeightConstraint!.constant
                            self.contentViewHeightConstraint?.constant = self.bottomContainerViewHeightConstraint!.constant + self.topContainerViewHeight!
                            self.verticalRoomView.showbtnViewAllButton()
                            self.view.layoutIfNeeded()
                            self.verticalRoomView.roomsOwner = values
                        }
                        
                        DispatchQueue.main.async {
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    //MARK: VerticalPostViewDelegate
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,collectionCell cell: UICollectionViewCell, didSelectCellAt indexPath: IndexPath?){
        let vc = RoomDetailVC()
        vc.viewType = .detailForOwner
        vc.room = rooms[indexPath!.row]
        let mainVC = UIViewController()
        let nv = UINavigationController(rootViewController: mainVC)
        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,onClickButton button:UIButton){
        
    }
    //MARK: Others
    @objc func onClickBtnSetting(){
        
    }
}
