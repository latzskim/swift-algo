import Foundation

public class Node<Value> {
    public var value: Value
    public var next: Node?

    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

public struct LinkedList<Value> {
    private var head: Node<Value>?
    private var tail: Node<Value>?
    private var elemCount: Int = 0

    public var isEmpty: Bool {
        return head == nil
    }

    public var count: Int {
        return elemCount
    }

    public init() {}

    public mutating func push(_ value: Value) {
        let newNode = Node(value: value, next: head)
        head = newNode
        if tail == nil {
            tail = head
        }
        elemCount += 1
    }

    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        let newNode = Node(value: value)
        tail?.next = newNode
        tail = newNode
        elemCount += 1
    }

    public func node(at index: Int) -> Node<Value>? {
        guard index >= 0 else { return nil }
        
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }

    public mutating func insert(_ value: Value, after node: Node<Value>) {
        guard node !== tail else {
            append(value)
            return
        }
        node.next = Node(value: value, next: node.next)
        elemCount += 1
    }

    @discardableResult
    public mutating func insert(_ value: Value, at index: Int) -> Bool {
        guard index >= 0 && index <= count else { return false }
        
        if index == 0 {
            push(value)
            return true
        } else if index == count {
            append(value)
            return true
        }

        if let previousNode = node(at: index - 1) {
            previousNode.next = Node(value: value, next: previousNode.next)
            elemCount += 1
            return true
        }
        
        return false
    }

    public mutating func pop() -> Value? {
        guard let headNode = head else { return nil }
        
        head = headNode.next
        if head == nil {
            tail = nil
        }
        elemCount -= 1
        return headNode.value
    }

    public mutating func removeLast() -> Value? {
        return remove(at: count - 1)
    }

    public mutating func remove(at index: Int) -> Value? {
        guard index >= 0 && index < count else { return nil }
        
        if index == 0 {
            return pop()
        }

        var previousNode = head
        var currentNode = head
        var currentIndex = 0

        while let nextNode = currentNode?.next, currentIndex < index {
            previousNode = currentNode
            currentNode = nextNode
            currentIndex += 1
        }

        previousNode?.next = currentNode?.next
        if previousNode?.next == nil {
            tail = previousNode
        }

        elemCount -= 1
        return currentNode?.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next)
    }
}
