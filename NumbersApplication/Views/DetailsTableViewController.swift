import UIKit
import SDWebImage

class DetailsTableViewController: UITableViewController  {

    var number: Number? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        tableView.isUserInteractionEnabled = false
        tableView.register(NumberCell.self)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NumberCell.self, for: indexPath)
        cell.number = number
        return  cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
}

extension DetailsTableViewController: NumberSelectionDelegate  {
    
    func numberSelected(_ number: Number) {
        self.number = number
    }
    
}
