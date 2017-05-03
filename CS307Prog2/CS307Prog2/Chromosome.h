//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Chromosome.h
// Author: Cray L. Pella
// Description: Chromosome.h/.cpp is used to represent a chromosome composed 
//				of two strands containing genes. 
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
using namespace std;
#include "Gene.h"
#include "MasterGene.h"
#include <vector>
#include <string.h>
#pragma once

class Chromosome
{
private:
	vector<Gene *>m_geneReferenceStrand1;
	vector<Gene *>m_geneReferenceStrand2;
	int m_iNumGene;
	bool m_bCrossed;

public:
	Chromosome();
	~Chromosome();
	void addGene(Gene *ref, int strandNum);
	Gene *getGene(int location, int strandNum);
	char *buildChromosomeStrand();
	int getGeneNum();
	bool getm_bCrossed();
};