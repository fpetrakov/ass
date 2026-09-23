pub const ChessboardError = error{
    IndexOutOfBounds,
};

pub fn square(comptime index: usize) ChessboardError!u64 {
    if (index < 1 or index > 64)
        return ChessboardError.IndexOutOfBounds;
    return 1 << (index - 1);
}

pub fn total() u64 {
    comptime var sum = 0;
    inline for (1..65) |i| {
        sum += try comptime square(i);
    }
    return sum;
}
