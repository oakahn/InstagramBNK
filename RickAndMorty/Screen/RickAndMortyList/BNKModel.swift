import Foundation
import ObjectMapper

class BNKModel: Mappable {
  
  var image: String?
  var memName: String?
  
  required init?(map: Map) { }
  
  func mapping(map: Map) {
    image <- map["meminsta_link"]
    memName <- map["mem_nickname"]
  }
}
