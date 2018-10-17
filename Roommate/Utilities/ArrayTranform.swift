
import RealmSwift
import ObjectMapper
import SwiftyJSON
//class ListTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
//    typealias Object = List<T>
//    typealias JSON = Array<AnyObject>
//    
//    let mapper = Mapper<T>()
//    
//    func transformFromJSON(_ value: Any?) -> List<T>? {
//        var result = List<T>()
//        if let tempArr = value as! Array<AnyObject>? {
//            for entry in tempArr {
//                let mapper = Mapper<T>()
//                let model : T = mapper.map(JSONObject: entry)!
//                result.append(model)
//            }
//        }
//        return result
//    }
//    
//    func transformToJSON(_ value: Object?) -> JSON? {
//        var results = [AnyObject]()
//        if let value = value {
//            for obj in value {
//                let json = mapper.toJSON(obj)
//                results.append(json as AnyObject)
//            }
//        }
//        return results
//    }
//}
