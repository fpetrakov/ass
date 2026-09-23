pub fn binarySearch(target: usize, items: []const usize) ?usize {
    var left = 0;
    var right = items.len;

    while (left < right) {
        const mid = (left + right) / 2;

        if (items[mid] == target) {
            return mid;
        } else if (items[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return null;
}
