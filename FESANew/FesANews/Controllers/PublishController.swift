
import UIKit

class PublishController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var contentView: UITextView!
  @IBOutlet weak var publishButton: UIButton!
  
  let userDefaults = UserDefaults.standard
  var newsService: NewsService?
  var dateService: DateService?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    hideKeyboardWhenTappedAround()
    
//    userDefaults.removeObject(forKey: "institutionName")
//    userDefaults.removeObject(forKey: "nickname")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if getStatusOfAccount() {
      setRightNavigationButton( hasAccount: true )
      if let name = userDefaults.string(forKey: "institutionName") {
        nameLabel.text = "¡Hola, \(name)!"
      }
    }
  }
  
  private func setup() {
    setupDependencies()
    if !getStatusOfAccount() {
      showModal()
      setRightNavigationButton( hasAccount: false )
    } else {
      setRightNavigationButton( hasAccount: true )
    }
    setupUi()
  }
  
  private func setupDependencies() {
    newsService = BasicService.shared.newsService
    dateService = BasicService.shared.dateService
  }
  
  private func setRightNavigationButton( hasAccount: Bool ) {
    if hasAccount {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(goToMyAccount))
    } else {
     self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAccount))
    }
  }
  
  @objc func goToMyAccount() {
    performSegue(withIdentifier: "institutionSegue2", sender: self)
  }
  
  @objc func addAccount() {
    showModal()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let controller = segue.destination as? InstitutionController {
      controller.newsList = newsService?.getNewsListFromRam()
      var newModel = NewModel()
      newModel.nickname = userDefaults.string(forKey: "nickname")
      newModel.institutionName = userDefaults.string(forKey: "institutionName")
      controller.selectedNew = newModel
    }
  }
  
  private func setupUi () {
    if let name = userDefaults.string(forKey: "institutionName") {
      nameLabel.text = "¡Hola, \(name)!"
    }
    publishButton.layer.cornerRadius = 20.0
    publishButton.addTarget(self, action: #selector(publishAction), for: .touchUpInside)
    
    containerView.layer.cornerRadius = 20.0
    contentView.layer.cornerRadius = 20.0
  }
  
  @objc func publishAction() {
    if let institution = userDefaults.string(forKey: "institutionName") {
      let date = dateService!.dateFormatterForFirebase(date: Date())
      publishRequest(institution: institution,
                     nickname: userDefaults.string(forKey: "nickname") ?? "",
                     date: date,
                     content: contentView.text)
    } else {
      presentAlert( title: "Error", message: "Debes de registrarte para poder publicar")
    }
  }
  
  private func publishRequest( institution:String, nickname: String, date: String, content:String ) {
    newsService!.publishNew(institution: institution, nickname: nickname, date: date, content: content, success: {
      self.presentAlert( title: "Completado", message: "¡Noticia publicada con éxito!")
    }) { (error) in
      self.presentAlert( title: "Error", message: "Ocurrió un error, asegurate de estar conectado a una red")
    }
  }
  
  private func presentAlert( title: String, message: String ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
      alert.dismiss(animated: true, completion: nil)
    }))
    present(alert, animated: true, completion: nil)
  }
  
  private func showModal() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "accountInfo") as! AccountInfoController
    present(vc, animated: true, completion: nil)
  }
  
  private func getStatusOfAccount() -> Bool {
    let data = userDefaults.string(forKey: "institutionName")
    return data != nil ? true : false
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
    


}
