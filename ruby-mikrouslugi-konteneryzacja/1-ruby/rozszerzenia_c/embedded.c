#include <ruby.h>
int main(int argc, char* argv[])
{
	// Utworzenie VM
	ruby_init();

	// Tutaj kod Ruby

	// Wyłączenie VM
	return ruby_cleanup(0);
} // main