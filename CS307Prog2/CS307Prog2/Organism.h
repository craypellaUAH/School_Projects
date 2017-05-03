//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Organism.h
// Author: Cray L. Pella
// Description: Organism.h/.cpp is used to represent a parent organism
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
using namespace std;
#include <vector>
#include "Chromosome.h"

class Organism
{
private:
	vector<Chromosome *>m_chroRef;
	char m_cGenus[128];
	char m_cSpecies[128];
	char m_cScientificName[128];
	char m_cCommonName[128];
	int m_iChromosomeNum;

public:
	Organism(char *temp1, char *temp2, char *temp3, char *temp4);
	~Organism();
	void addChromosome(Chromosome *temp);
	Chromosome *getChromosome(int location);
	char *getGenus();
	char *getSpecies();
	char *getCommonName();
	char *getScientificName();
	int getChromosomeNum();
};