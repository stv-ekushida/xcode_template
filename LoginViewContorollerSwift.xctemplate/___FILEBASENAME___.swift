//___FILEHEADER___

import UIKit

final class ___FILEBASENAME___: UIViewController {
    
    enum LoginButtonStatus {
        case inActive
        case active
        
        var color: UIColor {
            
            switch self {
            case .inActive:
                return .lightGray
            case .active:
                return .blue
            }
        }
        
        var isEnabled: Bool {
            
            switch self {
            case .inActive:
                return false
            case .active:
                return true
            }
        }
    }
    
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    private var loginStatus = LoginButtonStatus.inActive
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setLoginButtonStatus(status: .inActive)
    }
    
    private func setupObservers() {
        emailTextField.addTarget(self,
                                 action: #selector(textFieldDidChange(_:)),
                                 for: .editingChanged)
        passwordTextField.addTarget(self,
                                    action: #selector(textFieldDidChange(_:)),
                                    for: .editingChanged)
    }
    
    //MARK : - IBAction
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
        
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        
        let result = loginCheck()
        if !result {
            return
        }
        
        //TODO : ログインAPIを呼ぶ処理

        setLoginButtonStatus(status: .inActive)
    }
    
    @IBAction func didTapForgotPassword(_ sender: UIButton) {
        
        //TODO : パスワード忘れの処理
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let mailText = emailTextField.text, let passwordText = passwordTextField.text else {
            setLoginButtonStatus(status: .inActive)
            return
        }
        
        if mailText.isEmpty || passwordText.isEmpty {
            setLoginButtonStatus(status: .inActive)
            return
        }
        setLoginButtonStatus(status: .active)
    }
    
    private func setLoginButtonStatus(status: LoginButtonStatus) {
        loginButton.isEnabled = status.isEnabled
        loginButton.backgroundColor = status.color
    }
    
    private func loginCheck() -> Bool {
        
        if let mail = emailTextField.text, let password = passwordTextField.text {
            
            // メールアドレスチェック
            if mail.isEmpty {
                return false
            }
            
            if !(mail.count > 20) || !mail.isEmail() {
                return false
            }
            
            // パスワードチェック
            if password.isEmpty {
                return false
            }
            
            if !(password.count > 20) {
                return false
            }
        }
        return true
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField === emailTextField {
            passwordTextField.becomeFirstResponder()
            return false
        }
        
        if textField === passwordTextField && loginButton.isEnabled {
            textField.resignFirstResponder()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.didTapLogin(weakSelf.loginButton)
            }
            return false
        }
        return true
    }
}
