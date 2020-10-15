import UIKit
import SDWebImage

protocol MasterTableViewControllerDelegate {
    func didSelect(number: Number)
}

class MasterTableViewController: UITableViewController {
    
    var delegate: MasterTableViewControllerDelegate?
    
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
        fetchNumbers()
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
        delegate?.didSelect(number: numbers[indexPath.row])
    }
    
    private func fetchNumbers() {
        NetworkManager.shared.fetch(Numbers.self, url: .numbers) { [weak self] numbers, error in
            guard error == nil else { return }
            guard let numbers =  numbers else { return }
            self?.numbers = numbers
            self?.delegate?.didSelect(number: numbers[0])
            self?.tableView.delegate?.tableView?(self!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        }
    }
    
    private func setupTableView() {
        tableView.register(NumberCell.self)
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
    }
}

