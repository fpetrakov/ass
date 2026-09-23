const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    const NUM_OF_LETTERS = 26;
    var found = [_]bool{false} ** NUM_OF_LETTERS;

    for (0..str.len) |i| {
        const char = std.ascii.toLower(str[i]);

        if (char >= 'a' and char <= 'z') {
            found[char - 'a'] = true;
        }
    }

    for (0..found.len) |i| {
        if (found[i] == false) return false;
    }

    return true;
}
