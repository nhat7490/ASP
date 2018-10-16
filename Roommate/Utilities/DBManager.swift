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
        return realm.objects(UtilityModel.self).first != nil ? true : false
    }
    func isExistedDistrict()->Bool{
        let realm = try! Realm()
        return realm.objects(DistrictModel.self).first != nil ? true : false
    }
    func isExistedCity()->Bool{
        let realm = try! Realm()
        return realm.objects(CityModel.self).first != nil ? true : false
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
    
//    //For Utilities
//
//    func getUtility(id:Int) -> UtilityModel?{
//        return  realm.object(ofType: UtilityModel.self, forPrimaryKey: id)
//    }
//
//    func getUtilities() -> Results<UtilityModel>?{
//        return  realm.objects(UtilityModel.self)
//    }
//
//    func addUtilities(utilities:[UtilityModel])->Bool{
//
//        do{
//            try realm.write {
//                realm.add(utilities)
//            }
//            return true
//        }catch{
//            return false
//        }
//    }
//
//    func deleteAllUtility() {
//        do {
//            let districts = realm.objects(UtilityModel.self)
//            try realm.write {
//                realm.delete(districts)
//            }
//        } catch  {
//            print("Cannot delete all Disctrict")
//        }
//    }
//
//    //For district
//    func getDistrict(id:Int) -> DistrictModel?{
//        return  realm.object(ofType: DistrictModel.self, forPrimaryKey: id)
//    }
//
//    func getDistrictsByCityId(id:Int) -> Results<DistrictModel>?{
//        return  realm.objects(DistrictModel.self).filter("cityId = %d", id)
//    }
//    func getDistricts() -> Results<DistrictModel>?{
//        return  realm.objects(DistrictModel.self)
//    }
//
//    func addDistricts(districts:[DistrictModel])->Bool{
//
//        do{
//            try realm.write {
//                realm.add(districts)
//            }
//            return true
//        }catch{
//            return false
//        }
//    }
//
//    func deleteAllDistricts() {
//        do {
//            let districts = realm.objects(DistrictModel.self)
//            try realm.write {
//                realm.delete(districts)
//            }
//        } catch  {
//            print("Cannot delete all Disctrict")
//        }
//    }
//
//
//    //For city
//    func getCity(id:Int) -> CityModel?{
//        return  realm.object(ofType: CityModel.self, forPrimaryKey: id)
//    }
//
//    func getCities() -> Results<CityModel>?{
//        return  realm.objects(CityModel.self)
//    }
//
//    func addCities(cities:[CityModel])->Bool{
//
//        do{
//            try realm.write {
//                realm.add(cities)
//            }
//            return true
//        }catch{
//            return false
//        }
//    }
//
//    func deleteAllCities() {
//        do {
//            let cities = realm.objects(CityModel.self)
//            try realm.write {
//                realm.delete(cities)
//            }
//        } catch  {
//            print("Cannot delete all city")
//        }
//    }


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
