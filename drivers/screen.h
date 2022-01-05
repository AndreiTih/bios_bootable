#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
// Attribute byte for our default colour scheme .
#define WHITE_ON_BLACK 0x0f
// Screen device I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

/* Print a char on the screen at col , row , or at cursor position */
void print_char(char character , int col = -1, int row = -1, char attribute_byte = WHITE_ON_BLACK);

int handle_scrolling(int offset);

int get_screen_offset(int col,int rows);

int get_cursor();

void set_cursor (int offset);

void print_at(char* message , int col = -1, int row = -1);

void clear_screen();
