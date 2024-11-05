import Foundation

public class Node<V> {
    public var value: V
    public var next: Node?

    public init(value: V, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

public struct LinkedList<V> {
    var head: Node<V>?
    var tail: Node<V>?
    var count: Int

    public init() {
        count = 0
    }

    public var isEmpty: Bool {
        head == nil
    }

    public mutating func push(_ value: V) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }

        count += 1
    }

    public mutating func append(_ value: V) {
        guard !isEmpty else {
            // push already has count +1
            push(value)
            return
        }

        tail!.next = Node(value: value)
        tail = tail!.next

        count += 1
    }

    public func node(at index: Int) -> Node<V>? {
        var currNode = head
        var currIdx = 0

        while currNode != nil && currIdx < index {
            currNode = currNode!.next
            currIdx += 1
        }

        return currNode
    }

    public mutating func insert(_ value: V, after node: Node<V>) {
        guard node !== tail else {
            append(value)
            return
        }

        node.next = Node(value: value, next: node.next)
    }

    @discardableResult
    public mutating func insert(_ value: V, at index: Int) -> Bool {
        if index > count {
            return false
        }

        guard !isEmpty && index > 0 else {
            push(value)
            return true
        }

        let nodeAt = node(at: index)
        // Here we are trying to inser to tail.next
        if nodeAt == nil {
            append(value)
            return true
        }

        let insertNode = Node(value: value, next: nodeAt!)
        let nodeAtPrev = node(at: index - 1)!
        nodeAtPrev.next = insertNode
        count += 1

        return true
    }

    public func len() -> Int {
        return count
    }

    public mutating func pop() -> V? {
        if let v = head {
            head = v.next
            if head == nil {
                tail = nil
            }
            count -= 1
            return v.value
        }
        return nil
    }

    public mutating func removeLast() -> V? {
        remove(at: count - 1)
    }

    public mutating func remove(at index: Int) -> V? {
        guard !isEmpty && index >= 0 && index < count else {
            return nil
        }

        if index == 0 {
            return pop()
        }

        var prev = head
        var curr = head
        var idx = 0

        while let next = curr?.next {
            if idx == index {
                break
            }

            prev = curr
            curr = next
            idx += 1
        }

        prev?.next = curr?.next
        if prev?.next == nil {
            tail = nil
        }

        count -= 1

        return curr?.value

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
