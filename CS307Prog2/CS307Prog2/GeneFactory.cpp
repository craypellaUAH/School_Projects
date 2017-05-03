//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: GeneFactory.cpp
// Author: Cray L. Pella
// Description: GeneFactory.h/.cpp is used to build instances of the Gene
//				and MasterGene classes
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "GeneFactory.h"

GeneFactory::GeneFactory()
{
	m_pPar = GeneticsSimDataParser::getInstance(); 
}

GeneFactory::~GeneFactory()
{
	
}

GeneFactory *GeneFactory::getInstance()
{
	static GeneFactory *theInstance = NULL;
	if(theInstance == NULL)
	{
		theInstance = new GeneFactory();
	}
	return theInstance;
}

MasterGene *GeneFactory::buildMasterGene()
{	
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
	char *temp5;
	char atemp5[128];
	temp5 = atemp5;
	double *temp6;
	double atemp6;
	temp6 = &atemp6;

	m_pPar->getGeneData(temp1, temp2, temp3, temp4, temp5, temp6);
	MasterGene *hold = new MasterGene(temp1, temp2, temp3, temp4, temp5, temp6);
	return hold;

}

Gene *GeneFactory::buildGene(char sym)
{
	Gene *temp = new Gene(sym);
	return temp;
}
