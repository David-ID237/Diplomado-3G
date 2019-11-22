
import UIKit

class AccountInfoController: UIViewController, UITextFieldDelegate {

  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var saveButton: UIButton!
  
  let userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    setup()
  }
  
  private func setup() {
    setupUi()
  }
  
  private func setupUi() {
    containerView.layer.cornerRadius = 20.0
    
    saveButton.layer.cornerRadius = 20.0
    saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
  }
  
  @objc func saveAction() {
    if (nameTextField.text != "" && nicknameTextField.text != "") &&
      (nameTextField.text != nil && nicknameTextField.text != nil) {
      
      userDefaults.set( nameTextField.text, forKey: "institutionName")
      userDefaults.set( nicknameTextField.text, forKey: "nickname")
      dismiss(animated: true, completion: nil)
    } else {
      showAlert()
    }
  }
  
  func showAlert() {
    let alert = UIAlertController(title: "Error", message: "Debes llenar ambos campos para continuar", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
      alert.dismiss(animated: true, completion: nil)
    }))
    present(alert, animated: true, completion: nil)
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self,
                                     action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @IBAction func cancelAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
