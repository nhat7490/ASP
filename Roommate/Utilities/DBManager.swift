//
// Created by TrinhHC on 10/9/18.
// Copyright (c) 2018 TrinhHC. All rights reserved.
//

import Foundation
import RealmSwift
class DBManager {
    static let shared:DBManager = DBManager()
    
    //For check data
    func isExistedUtility()->Bool{
        let realm = try! Realm()
        return realm.objects(UtilityModel.self).isEmpty
    }
    func isExistedDistrict()->Bool{
        let realm = try! Realm()
        return realm.objects(DistrictModel.self).first != nil ? true : false
    }
    func isExistedCity()->Bool{
        let realm = try! Realm()
        return realm.objects(CityModel.self).first != nil ? true : false
    }
    
    func isExisted<T:BaseModel>(ofType:T.Type)->Bool{
        let realm = try! Realm()
        return realm.objects(T.self).count != 0
    }
    //For Common
    func getRecord<T:BaseModel>(id:Int,ofType:T.Type)->T?{
        let realm = try! Realm()
        return realm.object(ofType:T.self, forPrimaryKey: id)
    }
    func getRecords<T:BaseModel>(ofType:T.Type) -> Results<T>?{
        let realm = try! Realm()
        return  realm.objects(T.self)
    }
    
    func addRecords<T:BaseModel>(ofType:T.Type,objects:[T])->Bool{
        let realm = try! Realm()
        do{
            try realm.write {
                realm.add(objects)
            }
            return true
        }catch{
            return false
        }
    }
    
    func deleteAllRecords<T:BaseModel>(ofType:T.Type) {
        let realm = try! Realm()
        do {
            let objects = realm.objects(T.self)
            try realm.write {
                realm.delete(objects)
            }
        } catch  {
            print("Cannot delete all Disctrict")
        }
    }
    func updateRecord<T:BaseModel>(ofType:T.Type,object:T)->Bool{
        let realm = try! Realm()
        do{
            try realm.write {
                realm.add(object, update: true)
            }
            return true
        }catch{
            return false
        }
    }
    
    //For Setting
    func getSetting() -> SettingModel?{
        let realm = try! Realm()
        return  realm.objects(SettingModel.self).first
        
    }
    func addSetting(setting:SettingModel)->Bool{
        let realm = try! Realm()
        do{
            try realm.write {
                realm.add(setting, update: true)
            }
            return false
        }catch{
            return false
        }
    }
    func deleteAllSetting(){
        let realm = try! Realm()
        do {
            guard let setting = getSetting() else{
                return
            }
            try realm.write {
                realm.delete(setting)
            }
        } catch  {
            print("Cannot delete all user")
        }
    }
    
    
    //For User
    func getUser() -> UserModel?{
        let realm = try! Realm()
        return  realm.objects(UserModel.self).first
        
    }
    
    func addUser(user:UserModel)->Bool{
        let realm = try! Realm()
        do{
            self.deleteAllUsers()//delete all relative data when logout
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
        let realm = try! Realm()
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
        let realm = try! Realm()
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
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch  {
            print("Cannot delete all user")
        }
    }
}
