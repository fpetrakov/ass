const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var result = std.ArrayList(u8).empty;
    errdefer result.deinit(allocator);

    var wordsIter = mem.splitAny(u8, words, " -_");
    while (wordsIter.next()) |word| {
        if (word.len == 0) continue;
        try result.append(allocator, std.ascii.toUpper(word[0]));
    }
    return result.toOwnedSlice(allocator);
}
