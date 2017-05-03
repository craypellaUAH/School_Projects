//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: GeneticsSim.h
// Author: Cray L. Pella
// Description: GeneticsSim.h/.cpp is used to manage and run the simulation
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "OrganismFactory.h"
#include "MendelianCross.h"
#include <stdlib.h>
#include <sys/types.h>
#include <sys/timeb.h>
#include <time.h>

class GeneticsSim
{
private:
	int m_iNumOff;
	int m_iNumGene;
	vector<MasterGene *>m_geneRef;
	vector<Organism *>m_parents;
	GeneticsSimDataParser *m_pPar;
	vector<Offspring *>* m_children;
	GeneticsSim();
	void userQuery();
	void readInData();
	void startCross();
	void displayGENE_PARENTINFO();
	void displayResults();
	void getOffspringNum();
public:
	~GeneticsSim();
	static GeneticsSim *getInstance();




};