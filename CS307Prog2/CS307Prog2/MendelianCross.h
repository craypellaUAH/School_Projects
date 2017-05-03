//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: MendelianCross.h
// Author: Cray L. Pella
// Description: MendelianCross.h/.cpp is used to perform a Mendelian cross
//				between two organisms
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
#include <vector>
#include "OrganismFactory.h"
#include "Offspring.h"
using namespace std;

#pragma once

class MendelianCross
{
private:
	GeneFactory *m_pGFact;
	int m_iChroCount;
	vector<Offspring *>m_children;
	vector<MasterGene *>* m_geneReference;
	int m_iNumOffspring;
	MendelianCross();
	int m_iNumGene;
	int m_iTotalCrossed;

public:
	~MendelianCross();
	static MendelianCross *getInstance();
	void setGeneCount(int geneCount);
	void createOffspringVector();
	void setGeneReference(vector<MasterGene *>* geneRef);
	vector<Offspring *> *getOffspring();
	void startCross(int numOffspring, Organism *p1, Organism *p2);
	void search_AddOffspring(char *pass);
	int getTotalCrossed();
};