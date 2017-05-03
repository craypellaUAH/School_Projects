//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: ChromosomeFactory.h
// Author: Cray L. Pella
// Description: ChromosomeFactory.h/.cpp is used to build instances of the
//				Chromosome class
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
#include "GeneticsSimDataParser.h"
#include "Chromosome.h"
#include "GeneFactory.h"

using namespace std;

#pragma once

class ChromosomeFactory
{
private:
	GeneFactory *m_pGFact;
	GeneticsSimDataParser *m_pPar;
	ChromosomeFactory();

public:
	~ChromosomeFactory();
	Chromosome *buildChromosome(int parentNum);
	static ChromosomeFactory *getInstance();
};