import UIKit

protocol RickAndMortyListVCProtocol {
  func showRickAndMortyList(_ rickAndMortyListResultsModel: [RickAndMortyListResultsModel])
  func showBNKList(_ bnkList: [BNKModel])
}

class RickAndMortyListVC: UIViewController {
  
  let mainView = RickAndMortyListMainView()
  lazy var presenter = RickAndMortyListPresenter(self)
  
  var bnkList: [BNKModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setupMainView(view: view)
    setupTable()
    presenter.callBNKService()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupTable() {
    mainView.tableBNKList.estimatedRowHeight = 300
    mainView.tableBNKList.rowHeight = UITableView.automaticDimension
    mainView.tableBNKList.register(BNKTableViewCell.self, forCellReuseIdentifier: "cell")
    mainView.tableBNKList.dataSource = self
    mainView.tableBNKList.delegate = self
    mainView.tableBNKList.separatorStyle = .none
    mainView.tableBNKList.showsVerticalScrollIndicator = false
  }
}

extension RickAndMortyListVC: RickAndMortyListVCProtocol {
  
  func showRickAndMortyList(_ rickAndMortyListResultsModel: [RickAndMortyListResultsModel]) {
    print(rickAndMortyListResultsModel.toJSON())
  }
  
  func showBNKList(_ bnkList: [BNKModel]) {
    self.bnkList += bnkList
    mainView.tableBNKList.reloadData()
  }
}

extension RickAndMortyListVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bnkList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BNKTableViewCell else {
      return UITableViewCell()
    }
    
    cell.selectionStyle = .none
        
    guard let image = bnkList[indexPath.row].image else { return UITableViewCell() }
    guard let url = URL(string: image) else { return UITableViewCell() }
    
    cell.bnkImage.downloadImage(from: url)
    cell.bnkNameLabel.text = "\(bnkList[indexPath.row].memName ?? "").bnk48official"
    
    return cell
  }
}
