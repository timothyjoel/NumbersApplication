import UIKit
import SDWebImage

class DetailsTableViewController: UITableViewController  {
    
    var number: Number
    
    init(number: Number) {
        self.number = number
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
