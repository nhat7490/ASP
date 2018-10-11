//
// Created by TrinhHC on 10/9/18.
// Copyright (c) 2018 TrinhHC. All rights reserved.
//

import Foundation
import RealmSwift
class DBManager {
    static let shared:DBManager = DBManager()
    private let realm:Realm
    private init(){
        realm = try! Realm()
    }

    //For User
    func getUser() -> UserModel?{
        return  realm.objects(UserModel.self).first
    }

    func addUser(user:UserModel)->Bool{
        
        do{
            guard let _ = getUser() else{
                try realm.write {
                    realm.add(user)
                }
                return true
            }
            return false
        }catch{
            return false
        }
    }

    func updateUser(user:UserModel)->Bool{
        do{
            try realm.write {
                realm.add(user, update:true)
            }
            return true
        }catch{
            return false
        }
    }

    func deleteUser(user:UserModel)->Bool{
        do{
            try realm.write {
                realm.delete(user)
            }
            return true
        }catch{
            return false
        }
    }
    func deleteAllUsers() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch  {
            print("Cannot delete all user")
        }
    }
}
