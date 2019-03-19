
# DAO 패턴이란?

**Data Access Object** 의 약자로 전체 비지니스 로직 중에서 데이터베이스에 SQL문을 전송하여 질의하거나 업데이트하는 로직만 **분리** 하여 별도의 독립적인 클래스로 구현한 것을 가리킨다. 이 구조는 객체 지향 프로그래밍에서 자주 사용되는 패턴중 하나로, 뷰 및 비지니스 로직 계층과 데이터베이스 처리 계층을 구분하여 명확하게 역할을 분담해 줄 뿐만 아니라 전체 코드를 단순화 하는 장점이 있다.
모든 데이터베이스 프로그래밍에서 사용되는 소프트웨어 구조 패턴이다.


## DAO 클래스

DAO 패턴에 따라 독립적으로 구현된 클래스를 DAO 클래스라고 하며, 주로 소스파일 이름뒤에 "DAO" 접미사가 붙는 것으로 명시한다.
DAO클래스가 되기 위해 만족해야하는 특별한 조건이나 인터페이스는 정해진 것이 없다.
MVC 패턴에서 역할에 따라 각각의 클래스가 Model-View-Controller로 나뉘어 지듯이 DAO 클래스 역시 역할에 의해 구분되는 클래스이다.

## DAO Class Implements

부서DAO 클래스를 우선 생성한다.

```swift
class DepartmentDAO {
	//부서 정보를 담을 튜플 타입 정의
    typealias DepartRecord = (Int, String, String)
}
```

부서(Department) 정보는 부서코드, 부서명, 부서 주소로 구성된다. 이들 값은 서로 연관성을 가지므로 각각의 변수로 정의하기보다는 컨테이너 타입의 객체에 담아 사용하는 것이 훨씬 효율적이다.

> 왜 튜플(Tuple)타입으로 정의하는가?

딕셔너리에 담기에는 타입이 다양하고, VO 패턴의 객체로 정의하기에는 너무 작업이 번거로워 질 수 있기 때문이다. 튜플은 복잡한 코드 작성 없이도 다양한 데이터를 간편하게 묶을 수 있는 매우 효율적인 자료구조이다.

> 튜플의 특징

- 다양한 타입을 저장할수 있다.
- 첨자 타입의 속성이 제공되지만, 메소드나 속성, subScript는 제공되지 않는다.
- 한번 입력된 튜플값의 변경은 불가능하다.
- 기능을 정의하는 클래스나 구조체가 존재하지 않는다.

그렇기 때문에 여러곳에서 참조해야할 경우라면 Tuple타입을 `typealias`와 함께 사용하는것이 효과적이다.

```swift
class DepartmentDAO {
    
    // SQLite 연결 및 초기화
    lazy var fmdb: FMDatabase! = {
        // 1. 파일 매니저 객체 생성
        let fileMgr = FileManager.default
        
        // 2. 샌드박스 내 문서 디렉터리에서 데이터베이스 파일 경로를 확인
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        // 3. 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite를 가져와 복사한다
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        // 4. 준비된 데이터베이스 파일을 바탕으로 FMDatabase객체를 생성한다
        let db = FMDatabase(path: dbPath)
        return db
        
    }()
    
    //생성자 소멸자를 정의 -> 데이터베이스 연결을 열고 닫는다
    init() {
    	self.fmdb.open()
	}
    deinit {
   		self.fmdb.close()
	}        
}
```

- 파일 매니저 객체를 생성한다.
- 샌드박스 내 문서 디렉터리에서 데이터베이스 파일의 경로를 추출한다.
- 해당 경로에 파일이 없다면 메인번들에 만들어둔 ht.sqlite 파일을 가져와 샌드박스에 복사한다
- 두번째또는 세번째 과정을 통해 샌드박스에 준비된 hr.sqlite 파일을 이용하여 FMDatabase 객체를 생성한다.

> 부서 목록을 읽어올 메소드 find

```swift
 func find() -> [DepartRecord] {
        var departList = [DepartRecord]()
        
        do {
            // 1. 부서 정보 목록을 가져올 SQL 작성 및 쿼리 실행
            let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                ORDER BY depart_cd ASC
                """
            
            let rs = try self.fmdb.excuteQuery(sql, values: nil)
            // 2. 결과 집합 추출
            
            while rs.next() {
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                
                // append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의
                departList.append( (Int(departCd), departTitle!, departAddr!))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
    }
```    

> 단일 부서 정보를 읽어올 메서드 get (=select)


```swift
 func get(departCd: Int) -> DepartRecode? {
        
        // 1. 쿼리 수행
        let sql = """
            SELECT depart_cd, depart_title, depart_addr
            FROM department
            WHERE depart_cd = ?
            """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
        
        // 결과 집합 처리
        if let _rs = rs {   // 결과 집합이 옵셔널 타입으로 반환되므로, 이를 일반 상수에 바인딩 하여 해제한다.
            _rs.next()
            
            let departId = _rs.int(forColumn: "depart_cd")
            let departTitle = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            
            return (Int(departId), departTitle!, departAddr!)
            
        } else {
            return nil
        }
    }
```    

> 부서 정보 추가 메서드 create (= insert)

```swift
    func create(title: String!, addr: String!) -> Bool {
        do {
            let sql = """
                INSERT INTO department (depart_title, depart_addr)
                VALUES( ? , ? )
            """
            try self.fmdb.executeUpdate(sql, values: [title, addr])
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
```

> 부서 정보 삭제 remove (= delete)

```swift
    func remove(departCd: Int) -> Bool {
        do {
            let sql = "DELETE FORM department WHERE depart_cd?"
            try.self.fmdb.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            print("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
```    




