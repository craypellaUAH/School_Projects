//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Prog2Main.cpp
// Author: Cray L. Pella
// Description: Prog2Main.cpp is used to initialize GeneticsSim
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
using namespace std;
#include "GeneticsSim.h"
#include <stdlib.h>
#include <sys/types.h>
#include <sys/timeb.h>
#include <time.h>

int main()
{
	GeneticsSim *gS = GeneticsSim::getInstance();
	system("PAUSE");
}