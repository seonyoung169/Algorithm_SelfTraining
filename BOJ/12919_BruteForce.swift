import Foundation

// boj 12919 A와 B 2, 완탐, 골드 5

struct Queue<T> {
    private var queue: [T] = []
    
    public var count: Int {
        return queue.count
    }
    
    public var front : T {
        return queue[0]
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
}

extension String {
    func substring(from : Int, to : Int) -> String {
        guard from < count, to >= 0, to-from >= 0 else { return "" }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to+1)
        
        return String(self[startIndex..<endIndex])
    }
}

let S = readLine()!
let T = readLine()!

func makeReverse(_ str: String) -> String {
    var reversed = ""
    for i in (1..<str.count).reversed() {
        reversed += str.substring(from: i, to: i)
    }
    
    return reversed
}

func solution(_ str: String) -> Int {
    
    var q = Queue<String>()
    q.enqueue(str)
    
    while !q.isEmpty {
        guard let cur = q.dequeue() else { continue }
        
        if cur.count == S.count {
            var isSame = true
            
            for i in 0..<S.count {
                if cur.substring(from: i, to: i) != S.substring(from: i, to: i) {
                    isSame = false
                    break
                }
            }
            
            if isSame { return 1}
            else { continue }
        }
        
        let size = cur.count
        
        if size == 1 { continue }
        
        if cur.substring(from: size-1, to: size-1) == "A" {
            q.enqueue(cur.substring(from: 0, to: size-2))
        }
        
        if cur.substring(from: 0, to: 0) == "B" {
            let reverse = makeReverse(cur)
            q.enqueue(reverse)
        }
    }
    
    return 0
}

print(solution(T))
