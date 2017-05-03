//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: GeneFactory.h
// Author: Cray L. Pella
// Description: GeneFactory.h/.cpp is used to build instances of the Gene
//				and MasterGene classes
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
#include <vector>
#include "MasterGene.h"
#include "GeneticsSimDataParser.h"
#include "Gene.h"
using namespace std;

#pragma once

class GeneFactory
{
private:
	int m_iGeneCount;
	vector<MasterGene *>m_geneReference;
	vector<Gene *>m_lesserGene;
	GeneFactory();
	GeneticsSimDataParser *m_pPar;
public:
	~GeneFactory();
	MasterGene *buildMasterGene();
	Gene *buildGene(char sym);
	static GeneFactory *getInstance();



};