//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: OrganismFactory.cpp
// Author: Cray L. Pella
// Description: OrganismFactory.h/.cpp is used to build instances of the 
//				Organism class
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "OrganismFactory.h"

OrganismFactory::OrganismFactory()
{
	m_pPar = GeneticsSimDataParser::getInstance();
	m_iChroLoop = 0;
	m_iOrganismNum = 0;
}

OrganismFactory::~OrganismFactory()
{

}

OrganismFactory *OrganismFactory::getInstance()
{
	static OrganismFactory *theInstance = NULL;
	if(theInstance == NULL)
	{
		theInstance = new OrganismFactory();
	}
	return theInstance;
}

// Builds an Organism class
Organism *OrganismFactory::buildOrganism()
{
	if(m_iOrganismNum < 2)
	{
		ChromosomeFactory *cF = ChromosomeFactory::getInstance();

	    int chroCount = m_pPar->getChromosomeCount();

		char *temp1;
		char atemp1[128];
		temp1 = atemp1;
	
		char *temp2;
		char atemp2[128];
		temp2 = atemp2;

		char *temp3;
		char atemp3[128];
		temp3 = atemp3;
	
		char *temp4;
		char atemp4[128];
		temp4 = atemp4;

		strcpy(temp1,m_pPar->getGenus());
		strcpy(temp2,m_pPar->getSpecies());
		strcpy(temp3,m_pPar->getScientificName());
		strcpy(temp4,m_pPar->getCommonName());

		Organism *temp = new Organism(temp1, temp2, temp3, temp4);

		for(int y = 0; y < chroCount; y++)
		{
			Chromosome *tester = cF->buildChromosome(m_iOrganismNum);
			temp->addChromosome(tester);
			m_iChroLoop++;
		}

		m_iOrganismNum++;
		return temp;
	}
	else
	{
		return NULL;
	}
}
