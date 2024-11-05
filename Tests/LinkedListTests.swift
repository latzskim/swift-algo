import Testing

@testable import LinkedList

struct LinkedListTests {
    @Test
    func Test_Push() {
        var x = LinkedList<Int>()
        x.push(10)
        x.push(20)
        #expect(String(describing: x) == "20 -> 10")
    }

    @Test
    func TestAppend() {
        var x = LinkedList<Int>()
        x.append(10)
        x.append(20)
        #expect(String(describing: x) == "10 -> 20")
    }

    @Test
    func TestNodeAt() {
        var x = LinkedList<Int>()
        #expect(x.node(at: 0) == nil)

        x.append(10)
        x.append(20)
        x.push(-1)

        #expect(x.node(at: 0)?.value == -1)
        #expect(x.node(at: 1)?.value == 10)
        #expect(x.node(at: 2)?.value == 20)
        #expect(x.node(at: 3) == nil)
    }

    @Test
    func TestInsertAfterNode() {
        var x = LinkedList<Int>()
        x.append(10)
        x.append(30)

        let firstNode = x.node(at: 0)!
        x.insert(20, after: firstNode)

        let lastNode = x.node(at: 2)!
        x.insert(40, after: lastNode)

        x.append(50)

        #expect(String(describing: x) == "10 -> 20 -> 30 -> 40 -> 50")
    }

    @Test
    func TestInsertAt() {
        var x = LinkedList<Int>()
        #expect(x.insert(1, at: 1) == false)

        x.append(10)
        x.append(30)

        #expect(x.insert(0, at: 0) == true)
        #expect(x.insert(20, at: 2) == true)
        #expect(x.insert(40, at: 4) == true)

        // Count = 5, cannot insert at 6th pos.
        #expect(x.insert(50, at: 6) == false)

        #expect(String(describing: x) == "0 -> 10 -> 20 -> 30 -> 40")

        #expect(x.insert(-1, at: 0) == true)
        #expect(x.insert(-2, at: 0) == true)
        #expect(x.insert(-3, at: 0) == true)

        #expect(String(describing: x) == "-3 -> -2 -> -1 -> 0 -> 10 -> 20 -> 30 -> 40")
    }

    @Test
    func TestLen() {
        var x = LinkedList<String>()
        x.append("b")
        x.insert("c", at: 1)

        let nodeC = x.node(at: 1)!
        x.insert("d", after: nodeC)

        x.push("a")

        #expect(String(describing: x) == "a -> b -> c -> d")
        #expect(x.count == 4)
    }

    @Test("edge case insert at")
    func TestInsertAtEdgeCase() {
        var x = LinkedList<Int>()
        x.insert(1, at: x.count)
        x.insert(2, at: x.count)
        x.insert(3, at: x.count)
        x.insert(4, at: x.count)
        #expect(String(describing: x) == "1 -> 2 -> 3 -> 4")
    }

    @Test
    func TestPop() {
        var x = LinkedList<Int>()
        x.append(1)
        x.append(2)
        x.append(3)

        #expect(x.count == 3)

        #expect(x.pop()! == 1)
        #expect(x.pop()! == 2)
        #expect(x.pop()! == 3)
        #expect(x.pop() == nil)

        #expect(x.count == 0)
    }

    @Test
    func TestRemoveLast() {
        var x = LinkedList<Int>()
        x.append(1)
        x.append(2)
        x.append(3)

        #expect(x.count == 3)

        #expect(x.removeLast()! == 3)
        #expect(x.removeLast()! == 2)
        #expect(x.removeLast()! == 1)
        #expect(x.removeLast() == nil)

        #expect(x.count == 0)
    }

    @Test
    func TestRemoveAt() {
        var x = LinkedList<Int>()
        x.append(1)
        x.append(2)
        x.append(3)

        #expect(x.count == 3)

        #expect(x.remove(at: 3) == nil)
        
        #expect(x.remove(at: 1)! == 2)
        #expect(x.remove(at: 0)! == 1)
        #expect(x.remove(at: 0)! == 3)
        #expect(x.remove(at: 0) == nil)

        #expect(x.count == 0)
    }
}
