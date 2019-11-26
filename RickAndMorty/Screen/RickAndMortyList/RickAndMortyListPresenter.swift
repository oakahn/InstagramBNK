import Foundation
import Alamofire
import ObjectMapper

protocol RickAndMortyListPresenterProtocol {
  func callRickAndMortyService()
  func callBNKService()
}

class RickAndMortyListPresenter {
  
  var vc: RickAndMortyListVCProtocol?
  
  init(_ vc: RickAndMortyListVCProtocol) {
    self.vc = vc
  }
}

extension RickAndMortyListPresenter: RickAndMortyListPresenterProtocol {
  
  func callRickAndMortyService() {
    Alamofire.request("https://rickandmortyapi.com/api/character/").responseJSON { (res) in
      guard let model = Mapper<RickAndMortyListModel>().map(JSONObject: res.result.value) else { return }
      guard let results = model.results else { return }
      self.vc?.showRickAndMortyList(results)
    }
  }
  
  func callBNKService() {
    let url = "https://www.bnk48.com/model/listMembersClassdb/listMembersAjax.php"
    let parameters: Parameters = [
      "page": 0,
      "MemId": 4,
      "method": "loadmore"
    ]
    
    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
      guard let resp = response.result.value else { return }
      guard let model = Mapper<BNKModel>().mapArray(JSONObject: resp) else { return }
      self.vc?.showBNKList(model)
    }
  }
}
