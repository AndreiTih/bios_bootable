#include "../drivers/screen.h"

void functionBeforeMain()
{
	print_at("peepepupu",0,0);
}

void _main(){
	clear_screen();
	
	print_at("------------------------------------------");
	print_char('\n');
	print_at("-------------Big boy terminal-------------");
	print_char('\n');
	print_at("------------------------------------------");
	print_char('\n');
	print_at("Enter command:");
	
}