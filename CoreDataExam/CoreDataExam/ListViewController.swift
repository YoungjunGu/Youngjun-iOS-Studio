//
//  ListViewController.swift
//  CoreDataExam
//
//  Created by youngjun goo on 01/04/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Data source 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    func fetch() -> [NSManagedObject] {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let manageContext = appDelegate.persistentContainer.viewContext
        // 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Company")
        // 데이터 가져오기
        
        do {
            let result = try manageContext.fetch(fetchRequest)
             return result
        } catch {
            return [NSManagedObject()]
        }
       
    }
    
    func save(name: String, address: String) -> Bool {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "Company", into: manageContext)
        
        object.setValue(name, forKey: "name")
        object.setValue(address, forKey: "address")
        object.setValue(Date(), forKey: "regdate")
        
        // 영구 저장소에 커밋되고 나면 list 배열 프로퍼티에 추가
        
        do {
            // 변경된 사항을 영구 저장소에 반영
            try manageContext.save()
            self.list.append(object)
            return true
        } catch {
            manageContext.rollback()
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn

        // Do any additional setup after loading the view.
    }
    
    @objc func add(_ sender: Any) {
        let alert = UIAlertController(title: "회사등록", message: nil, preferredStyle: .alert)
        
        alert.addTextField() { $0.placeholder = "회사명" }
        alert.addTextField() { $0.placeholder = "주소" }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, let address = alert.textFields?.last?.text else {
                return
            }
            
            if self.save(name: name, address: address) == true {
                self.tableView.reloadData()
            }
        })
        self.present(alert, animated: false)
    }
    
    func delete(object: NSManagedObject) -> Bool {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let manageCotext = appDelegate.persistentContainer.viewContext
        
        // 컨텍스트로부터 해당 객체 삭제
        manageCotext.delete(object)
        
        // 영구 저장소에 커밋한다.
        do {
            try manageCotext.save()
            return true
        } catch {
            manageCotext.rollback()
            return false
        }
    }
    
    
    

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell에 하나씩 값을 부여하기 위해 데이터 가져오기
        let record = self.list[indexPath.row]
        let name = record.value(forKey: "name") as? String
        let address = record.value(forKey: "address") as? String
        
        // cell 생성후 값 입력 작업
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell")!
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = address
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let object = self.list[indexPath.row]   //삭제할 대상 객체
        
        if self.delete(object: object) {
            // 코어 데이터에서 삭제하면 테이블 뷰에서 행을 삭제해야한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
