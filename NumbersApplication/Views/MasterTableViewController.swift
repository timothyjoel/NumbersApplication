import UIKit
import SDWebImage

class MainTableViewController: UITableViewController {
    
    var numbers: [Number] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Numbers"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        tableView.register(NumberCell.self)
        tableView.tableFooterView = UIView()
        NetworkManager.shared.fetch(Numbers.self, url: .numbers) { [weak self] numbers, error in
            guard error == nil else { return }
            guard let numbers =  numbers else { return }
            self?.numbers = numbers
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NumberCell.self, for: indexPath)
        cell.number = numbers[indexPath.row]
        return  cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numbers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            detailsViewController.number = numbers[indexPath.row]
//        } else {
//            detailsViewController.number = numbers[indexPath.row]
        let vc = DetailsTableViewController(number: numbers[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
}

