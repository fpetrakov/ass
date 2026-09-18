#include "stdint.h"
#include "resistor_color.h"

static resistor_band_t all_colors[] = {
   BLACK, BROWN, RED, ORANGE, YELLOW,
   GREEN, BLUE, VIOLET, GREY, WHITE
};

int color_code(resistor_band_t color)
{
   return (int)color;
}

resistor_band_t *colors(void)
{
   return all_colors;
}
