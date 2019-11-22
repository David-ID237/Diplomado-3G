
import Foundation
import UIKit

class TimeLineCustomCell: UITableViewCell {
  
  var institutionName: String?
  var nickname: String?
  var date: String?
  var content: String?
  
  var nameView: UILabel = {
    var name = UILabel()
    name.translatesAutoresizingMaskIntoConstraints = false
    return name
  }()
  
  var nicknameLabel: UILabel = {
    var nickname = UILabel()
    nickname.translatesAutoresizingMaskIntoConstraints = false
    return nickname
  }()
  
  var dateLabel: UILabel = {
    var dateLabel = UILabel()
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    return dateLabel
  }()
  
  var contentTextView: UILabel = {
    var text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(nameView)
    self.addSubview(nicknameLabel)
    self.addSubview(dateLabel)
    self.addSubview(contentTextView)
    
    setConstraints()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if let institutionName = institutionName {
      nameView.text = institutionName
      nameView.textColor = UIColor.AppColor.mainBlue
      nameView.font = UIFont(name: "Ubuntu-Bold", size: 18.0)
    }
    if let nickname = nickname {
      nicknameLabel.text = nickname
      nicknameLabel.textColor = UIColor.AppColor.nickNameGray
      nicknameLabel.font = UIFont(name: "Ubuntu-Medium", size: 14.0)
    }
    if let dateL = date {
      dateLabel.text = dateL.description
      dateLabel.textColor = UIColor.AppColor.nickNameGray
      dateLabel.font = UIFont(name: "Ubuntu-Medium", size: 14.0)
    }
    if let content = content {
      contentTextView.text = content
      contentTextView.font = UIFont(name: "Ubuntu-Regular", size: 15.0)
    }
  }
  
  private func setConstraints() {
    self.heightAnchor.constraint(greaterThanOrEqualToConstant: 150.0).isActive = true
    
    nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
    nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
    nameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
    nameView.textAlignment = .center
    nameView.numberOfLines = 0
    nameView.heightAnchor.constraint(greaterThanOrEqualToConstant: 25.0).isActive = true
    
    nicknameLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 0.0).isActive = true
    nicknameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
    nicknameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    nicknameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    
    dateLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 0.0).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 0.0).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
    dateLabel.textAlignment = .right
    dateLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    
    contentTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    contentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
    contentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
    contentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
    contentTextView.textAlignment = .justified
    contentTextView.numberOfLines = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented!")
  }
  
}
