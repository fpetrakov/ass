const std = @import("std");

pub fn modifier(score: u8) i8 {
    const s: f32 = @floatFromInt(score);
    const result = @floor((s - 10.0) / 2.0);
    return @trunc(result);
}

pub fn ability(random: std.Random) u8 {
    var min: u8 = 6;
    var sum: u8 = 0;
    for (0..4) |_| {
        const curr = random.uintLessThan(u8, 6) + 1;
        sum += curr;
        min = @min(min, curr);
    }
    return sum - min;
}

pub const Character = struct {
    strength: u8,
    dexterity: u8,
    constitution: u8,
    intelligence: u8,
    wisdom: u8,
    charisma: u8,
    hitpoints: u8,

    pub fn init(random: std.Random) Character {
        var character: Character = undefined;
        inline for (std.meta.fields(Character)) |field| {
            if (comptime std.mem.eql(u8, field.name, "hitpoints")) {
                character.hitpoints = @intCast(10 + modifier(character.constitution));
                continue;
            }
            @field(character, field.name) = ability(random);
        }
        return character;
    }
};
