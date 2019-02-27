import UIKit

//그룹 생성
let queueGroup = DispatchGroup()

let queue1 = DispatchQueue(label: "task1", attributes: .concurrent)
let queue2 = DispatchQueue(label: "task2", attributes: .concurrent)
let queue3 = DispatchQueue(label: "task3", attributes: .concurrent)

queue1.async(group: queueGroup) {
    print("task1")
}

queue2.async(group: queueGroup) {
    print("task2")
}

queue3.async(group: queueGroup) {
    print("task3")
}

queueGroup.notify(queue: DispatchQueue.main) {
    print("group notify")
}
