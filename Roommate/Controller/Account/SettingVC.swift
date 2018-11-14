//
//  FilterForRoom.swift
//  Roommate
//
//  Created by TrinhHC on 10/3/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
class SettingVC: BaseVC ,UITableViewDataSource,UITableViewDelegate{
    var settingActionsForRoommeberAndMember = [
        "SUGGEST_SETTING",
        "TITLE_SIGN_OUT"
    ]
    var settingActionsForRoomOwner = [
        "TITLE_SIGN_OUT"
    ]
    lazy var settingActionTableView:UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let user = DBManager.shared.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegateAndDataSource()
    }
    
    func setupUI(){
        title = "SETTING".localized
        setBackButtonForNavigationBar()
        
        view.addSubview(settingActionTableView)
        _ = settingActionTableView.anchor(view: view)
        
    }
    
    func setupDelegateAndDataSource(){
        settingActionTableView.delegate = self
        settingActionTableView.dataSource = self
        settingActionTableView.register(UINib(nibName: Constants.CELL_ACTIONTV, bundle: Bundle.main), forCellReuseIdentifier: Constants.CELL_ACTIONTV)
        
    }
    //MARK: UITableView DataSourse and Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.HEIGHT_CELL_ACTIONTV
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.roleId == Constants.ROOMOWNER ? settingActionsForRoomOwner.count : settingActionsForRoommeberAndMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ACTIONTV, for: indexPath) as! ActionTVCell
        cell.title = user?.roleId == Constants.ROOMOWNER ?   settingActionsForRoomOwner[indexPath.row].localized : settingActionsForRoommeberAndMember[indexPath.row].localized
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if user?.roleId == Constants.ROOMOWNER{
            switch indexPath.row{
            case 0:
                DBManager.shared.deleteAllUsers()
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window!.rootViewController = UINavigationController(rootViewController: Utilities.vcFromStoryBoard(vcName: Constants.VC_FIRST_LAUNCH, sbName: Constants.STORYBOARD_MAIN) )
                NotificationCenter.default.post(name: Constants.NOTIFICATION_SIGNOUT, object: nil)
                self.navigationController?.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }else{
            switch indexPath.row{
            case 0:
                break
            case 1:
                DBManager.shared.deleteAllUsers()
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window!.rootViewController = UINavigationController(rootViewController: Utilities.vcFromStoryBoard(vcName: Constants.VC_FIRST_LAUNCH, sbName: Constants.STORYBOARD_MAIN) ) 
                NotificationCenter.default.post(name: Constants.NOTIFICATION_SIGNOUT, object: nil)
                self.navigationController?.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        
        
        
        
    }
}
