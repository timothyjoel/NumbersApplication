import UIKit
import SDWebImage
import SnapKit

class NumberCell: UITableViewCell {
    
    private var loadingIndicator = UIActivityIndicatorView()
    private var numberImageView = UIImageView()
    private var nameLabel = UILabel()
    
    var number: Number? {
        didSet {
            numberImageView.sd_setImage(with: URL(string: number?.image ?? "")) { [weak self] _,_,_,_  in
                self?.loadingIndicator.removeFromSuperview()
            }
            nameLabel.text = number?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        setupLayout()
        setupIndicator()
        numberImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .red : .none
        textLabel?.textColor = selected ? .white : .black
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? .blue : .none
        textLabel?.textColor = highlighted ? .white : .black
    }
    
    private func setupIndicator() {
        loadingIndicator.startAnimating()
        loadingIndicator.style = .medium
        loadingIndicator.color = .systemGray
    }
    
    func setupLayout() {
        let offset = 16
        contentView.addSubviews(numberImageView, loadingIndicator, nameLabel)
        [numberImageView, loadingIndicator].forEach { (view) in
            view.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(offset)
                make.centerY.equalToSuperview()
            }
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(numberImageView.snp.trailing).offset(offset)
            make.centerY.equalToSuperview()
        }
    }
    
}

