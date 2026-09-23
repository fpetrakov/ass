const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    const NUM_OF_ALPHABET_LETTERS = 26;
    var found = [_]bool{false} ** NUM_OF_ALPHABET_LETTERS;

    for (0..str.len) |i| {
        const char = std.ascii.toLower(str[i]);
        if (char == ' ') continue;
        if (char == '-') continue;
        if (found[char - 'a']) return false;
        found[char - 'a'] = true;
    }

    return true;
}
