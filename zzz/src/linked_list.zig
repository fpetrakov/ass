pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *@This(), node: *Node) void {
            node.next = null;

            if (self.last) |last| {
                last.next = node;
                node.prev = last;
            } else {
                node.prev = null;
                self.first = node;
            }

            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *@This()) ?*Node {
            const last = self.last orelse return null;
            if (last.prev) |prev| {
                prev.next = null;
                self.last = prev;
            } else {
                self.first = null;
                self.last = null;
            }
            self.len -= 1;
            return last;
        }

        pub fn shift(self: *@This()) ?*Node {
            const first = self.first orelse return null;
            self.first = first.next;
            if (first.next) |next| {
                next.prev = null;
            } else {
                self.last = null;
            }
            self.len -= 1;
            return first;
        }

        pub fn unshift(self: *@This(), node: *Node) void {
            if (self.first) |first| {
                first.prev = node;
                node.next = first;
            } else {
                self.last = node;
            }
            self.first = node;
            self.len += 1;
        }

        pub fn delete(self: *@This(), node: *Node) void {
            var first = self.first;
            while (first) |curr| {
                if (curr == node) break;
                first = curr.next;
            }
            if (first == null) return;

            if (node.prev) |prev| {
                prev.next = node.next;
            } else {
                self.first = node.next;
            }

            if (node.next) |next| {
                next.prev = node.prev;
            } else {
                self.last = node.prev;
            }

            node.prev = null;
            node.next = null;
            self.len -= 1;
        }
    };
}
