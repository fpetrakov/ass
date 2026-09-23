const std = @import("std");

pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var src_end = s.len;
    var dest: usize = 0;

    while (src_end > 0) {
        var src_start = src_end - 1;

        const isContinuationByte = s[src_start] & 0xc0 == 0x80;
        if (src_start > 0 and isContinuationByte) {
            src_start -= 1;
        }

        const len = src_end - src_start;
        @memcpy(buffer[dest .. dest + len], s[src_start..src_end]);

        src_end = src_start;
        dest += len;
    }

    return buffer[0..s.len];
}
