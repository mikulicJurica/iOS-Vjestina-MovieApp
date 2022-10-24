import UIKit
import SnapKit

struct personView {
    let personName: String
    let personJob: String
    
    init(personName: String, personJob: String) {
        self.personName = personName
        self.personJob = personJob
    }
    
    func makePersonView() -> UIView {
        let personView = UIView()
        
        let personNameLabel = UILabel()
        personNameLabel.textColor = .black
        personNameLabel.font = UIFont(name: "Verdana-Bold", size: 14)
        personNameLabel.text = personName
        personView.addSubview(personNameLabel)

        let personJobLabel = UILabel()
        personJobLabel.textColor = .black
        personJobLabel.font = UIFont(name: "Verdana", size: 14)
        personJobLabel.text = personJob
        personView.addSubview(personJobLabel)
        
        personNameLabel.snp.makeConstraints({
            $0.leading.top.trailing.equalToSuperview()
        })
        
        personJobLabel.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(personNameLabel.snp.bottom).offset(5)
        })
        
        return personView
    }
}
