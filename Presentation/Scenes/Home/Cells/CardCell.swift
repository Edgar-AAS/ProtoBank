import UIKit
import Domain

public protocol CardCellDelegateProtocol: AnyObject {
    func addCardButtonDidTapped()
    func cardDidTapped(cardSelected: Card)
}

public final class CardCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CardCell.self)
    var collectionView: UICollectionView!
    
    private var cards: [Card] = []
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupView()
        contentView.backgroundColor = Colors.primaryColor
    }
    
    func goToLastItem() {
        collectionView.scrollToItem(at: IndexPath(item: cards.count - 1, section: 0), at: .right, animated: true)
    }
    
    public weak var delegate: CardCellDelegateProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var myCardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Meus cartões"
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    public lazy var addCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Icons.plus, for: .normal)
        button.tintColor = Colors.secundaryColor
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.secundaryColor.cgColor
        button.addTarget(self, action: #selector(addCardButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hexString: "0A2647")
        return button
    }()
    
    @objc private func addCardButtonTap() {
        delegate?.addCardButtonDidTapped()
    }
    
    private func setupCollectionView() {
        let layout = SnappingLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.primaryColor
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(PhysicalCardCell.self, forCellWithReuseIdentifier: PhysicalCardCell.reuseIdentifier)
        collectionView.register(DigitalCardCell.self, forCellWithReuseIdentifier: DigitalCardCell.reuseIdentifier)
    }
    
    func configureCell(with cards: [Card]) {
        self.cards = cards
        collectionView.reloadData()
    }
}
//MARK: - UICollectionViewDataSource
extension CardCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let card = cards[indexPath.row]
        
        if card.isVirtual {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DigitalCardCell.reuseIdentifier, for: indexPath) as? DigitalCardCell
            cell?.configureCell(with: card)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhysicalCardCell.reuseIdentifier, for: indexPath) as? PhysicalCardCell
            cell?.configureCell(with: card)
            return cell ?? UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension CardCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cardDidTapped(cardSelected: cards[indexPath.item])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CardCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width/1.2, height: collectionView.frame.size.height - 20)
    }
}

//MARK: - Configurate Views
extension CardCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(myCardsLabel)
        contentView.addSubview(addCardButton)
        contentView.addSubview(collectionView)
    }
    
    func setupConstrains() {
        myCardsLabel.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        addCardButton.fillConstraints(
            top: contentView.topAnchor,
            leading: nil,
            trailing: contentView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 16),
            size: .init(width: 70, height: 44)
        )
        
        collectionView.fillConstraints(
            top: myCardsLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: contentView.bounds.width * 0.8)
        )
    }
}
