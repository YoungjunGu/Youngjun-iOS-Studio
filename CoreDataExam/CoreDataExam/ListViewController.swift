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
        let result = try! manageContext.fetch(fetchRequest)
        return result
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
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
}
