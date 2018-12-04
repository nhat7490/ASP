//
//  RateVC.swift
//  Roommate
//
//  Created by TrinhHC on 11/29/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class RateVC: BaseVC {

    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        return sv
    }()

    let contentView:UIView={
        let cv = UIView()
        return cv
    }()

    lazy var topSingleRateView:SingleRateView = {
        let sv = SingleRateView()
        return sv
    }()

    lazy var centerSingleRateView:SingleRateView = {
        let sv = SingleRateView()
        return sv
    }()

    lazy var bottomSingleRateView:SingleRateView = {
        let sv = SingleRateView()
        return sv
    }()

    lazy var descriptionsView:DescriptionView = {
        let dv:DescriptionView = .fromNib()
        return dv
    }()

    var rateVCType:RateVCType?{
        didSet {

            if rateVCType == .room{
                title = "RATE_ROOM".localized
                topSingleRateView.singleRateViewType = .security
                centerSingleRateView.singleRateViewType = .location
                bottomSingleRateView.singleRateViewType = .utility
            }else{
                title = "RATE_MEMBER".localized
                topSingleRateView.singleRateViewType = .behavior
                centerSingleRateView.singleRateViewType = .lifestyle
                bottomSingleRateView.singleRateViewType = .payment
            }
        }
    }
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        //Add Navigation button
        let barButtonItem = UIBarButtonItem(title: "SAVE".localized, style: .done, target: self, action: #selector(onClickBtnSave))
        barButtonItem.tintColor  = .defaultBlue
        navigationItem.rightBarButtonItem = barButtonItem

        //Calculator constant
        let contentViewHeight = 3*Constants.HEIGHT_SINGLE_RATE_VIEW+Constants.HEIGHT_LARGE_SPACE


        //Add View
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topSingleRateView)
        contentView.addSubview(centerSingleRateView)
        contentView.addSubview(bottomSingleRateView)



        //Add Constrant

        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))

        } else {
            // Fallback on earlier versions

            _ = scrollView.anchor(topLayoutGuide.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))

        }

        _ = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor,UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10),CGSize(width: 0, height: contentViewHeight))
        _ = contentView.anchorWidth(equalTo:scrollView.widthAnchor)

        _ = topSingleRateView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_SINGLE_RATE_VIEW))
        _ = centerSingleRateView.anchor(topSingleRateView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_SINGLE_RATE_VIEW))
        _ = bottomSingleRateView.anchor(centerSingleRateView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_SINGLE_RATE_VIEW))
    }
    func setupDelegateAndDataSource(){
//        top
    }

    //MARK: Navigation bar button delegate
    @objc func onClickBtnSave(){

    }

}
