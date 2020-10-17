import os.log
import UIKit
import SDWebImage

protocol NumberSelectionDelegate: class {
  func numberSelected(_ number: Number)
}

class MasterTableViewController: UITableViewController {
    
    weak var delegate: NumberSelectionDelegate?
    
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
        setupTableView()
        fetchNumbers { [weak self] in
            guard let number = self?.numbers.first else { return }
            self?.delegate?.numberSelected(number)
            print("hell")
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
        delegate?.numberSelected(numbers[indexPath.row])
        if let detailViewController = delegate as? DetailsTableViewController {
            if let detailNavigationController = detailViewController.navigationController {
                splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
            }
        }
    }
    
    func fetchNumbers(completion: @escaping () -> ()) {
        NetworkManager.shared.fetch(Numbers.self, url: .numbers) { [weak self] numbers, error in
            guard error == nil else { return }
            guard let numbers =  numbers else { return }
            self?.numbers = numbers
            completion()
        }
    }
    
    private func setupTableView() {
        tableView.register(NumberCell.self)
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
    }
}

extension MasterTableViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        true
    }
}
