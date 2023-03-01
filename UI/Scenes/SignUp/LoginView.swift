import Foundation
import UIKit

public class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "BEF0CB")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Acesse sua conta com e email e senha"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.color = UIColor.systemGreen
        return loadingView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "68B984")
        button.tintColor = .black
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var emailTextField = FormTextField(placeholder: "E-mail")
    lazy var passwordTextField = FormTextField(placeholder: "Senha")
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
        addSubview(loginLabel)
        addSubview(loginDescriptionLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    func setupConstrains() {
        loginLabel.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 0)
        )
        
        loginDescriptionLabel.fillConstraints(
            top: loginLabel.bottomAnchor,
            leading: loginLabel.leadingAnchor,
            trailing: loginLabel.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0)
        )
        
        emailTextField.fillConstraints(
            top: loginDescriptionLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: emailTextField.leadingAnchor,
            trailing: emailTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        loginButton.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 32, bottom: 0, right: 32),
            size: .init(width: 0, height: 50)
        )
    }
}