//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: ChromosomeFactory.cpp
// Author: Cray L. Pella
// Description: ChromosomeFactory.h/.cpp is used to build instances of the
//				Chromosome class
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "ChromosomeFactory.h"

ChromosomeFactory::ChromosomeFactory()
{
	m_pPar = GeneticsSimDataParser::getInstance(); 
}

ChromosomeFactory::~ChromosomeFactory()
{

}

ChromosomeFactory *ChromosomeFactory::getInstance()
{
	static ChromosomeFactory *theInstance = NULL;
	if(theInstance == NULL)
	{
		theInstance = new ChromosomeFactory();
	}
	return theInstance;
}

Chromosome *ChromosomeFactory::buildChromosome(int parentNum)
{
	GeneFactory *gF = GeneFactory::getInstance();

	char *temp1;
	char atemp1[128];
	temp1 = atemp1;
	
	char *temp2;
	char atemp2[128];
	temp2 = atemp2;
	
		
	if(parentNum == 0)
	{
		m_pPar->getP1Chromosome(temp1, temp2);
	}
	else
	{
		m_pPar->getP2Chromosome(temp1, temp2);
	}

	Chromosome *temp = new Chromosome();

	char *line = strtok(temp1, " \n");
		
	while(line != NULL)
	{
		Gene *GeneTemp = gF->buildGene(line[0]);
		temp->addGene(GeneTemp, 1);
		line = strtok(NULL, " \n");
	}

	line = strtok(temp2, " \n");

	while(line != NULL)
	{
		Gene *GeneTemp = gF->buildGene(line[0]);
		temp->addGene(GeneTemp, 2);
		line = strtok(NULL, " \n");		
	}
			
	return temp;
		
}

