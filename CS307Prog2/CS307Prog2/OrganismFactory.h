//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: OrganismFactory.h
// Author: Cray L. Pella
// Description: OrganismFactory.h/.cpp is used to build instances of the 
//				Organism class
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
#include <vector>
#include "GeneticsSimDataParser.h"
#include "ChromosomeFactory.h"
#include "Organism.h"
using namespace std;

#pragma once

class OrganismFactory
{
private:
	ChromosomeFactory *m_pCFact;
	int m_iOrganismNum;
	int m_iChroLoop;
	OrganismFactory();
	GeneticsSimDataParser *m_pPar;

public:
	~OrganismFactory();
	Organism *buildOrganism();
	static OrganismFactory *getInstance();
};