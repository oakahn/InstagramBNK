import ObjectMapper

class RickAndMortyListModel: Mappable {
  
  var results: [RickAndMortyListResultsModel]?
  
  required init?(map: Map) { }
  
  func mapping(map: Map) {
    results <- map["results"]
  }
}

class RickAndMortyListResultsModel: Mappable {
  
  var name: String?
  var status: String?
  var gender: String?
  var image: String?
  
  required init?(map: Map) { }
  
  func mapping(map: Map) {
    name <- map["name"]
    status <- map["status"]
    gender <- map["gender"]
    image <- map["image"]
  }
}
