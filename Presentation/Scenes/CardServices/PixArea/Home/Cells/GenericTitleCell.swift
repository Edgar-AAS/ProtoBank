import UIKit

final class GenericTitleCell: UITableViewCell {
    static let reuseIdentifier = String(describing: GenericTitleCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    func setTitleForCell(textType: CellTitleType) {
        titleLabel.text = textType.rawValue
    }
}

extension GenericTitleCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    func setupConstrains() {
        titleLabel.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 8, left: 20, bottom: 10, right: 20)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}
