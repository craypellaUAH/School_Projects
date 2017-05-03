//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: MasterGene.cpp
// Author: Cray L. Pella
// Description: MasterGene.h/.cpp is used to represent all data defining a 
//				particular gene
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "MasterGene.h"
#include <string.h>

MasterGene::MasterGene(char *gT, char *dA, char *dS, char *rA, char *rS, double *cC)
{
	strcpy(m_cGeneTrait, gT);
	strcpy(m_cDomAllele, dA);
	strcpy(m_cRecAllele, rA);
	m_cDomSym = dS[0];
	m_cRecSym = rS[0];
	m_dCrossoverChance = *cC;
}

MasterGene::~MasterGene()
{

}

char *MasterGene::getGeneTrait()
{
	char *temp;
	temp = m_cGeneTrait;
	return temp;
}

char *MasterGene::getDomAllele()
{
	char *temp;
	temp = m_cDomAllele;
	return temp;
}

char MasterGene::getDomSym()
{
	return m_cDomSym;
}

char *MasterGene::getRecAllele()
{
	char *temp;
	temp = m_cRecAllele;
	return temp;
}

char MasterGene::getRecSym()
{
	return m_cRecSym;
}

double MasterGene::getCrossoverChance()
{
	return m_dCrossoverChance;
}


