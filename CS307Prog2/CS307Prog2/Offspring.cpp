//-------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Offspring.cpp
// Author: Cray L. Pella
// Description: Offspring.h/.cpp is used to represent a possible type of
//				offspring created from a Mendel Cross
// Date: 02/17/16
//
// I attest that this program is entirely my own work
//-------------------------------------------------------------------------

#include "Offspring.h"

//Constructor
Offspring::Offspring()
{
	m_iNumTypeOffspring = 0;
}
	
//Destructor
Offspring::~Offspring()
{
}

void Offspring::setGenotypeDesc(char *temp)
{
	strcpy(m_cGenotype, temp);
}

char *Offspring::getGenotypeDesc()
{
	return m_cGenotype;
}

void Offspring::setAllele(char *allele)
{
	strcpy(m_cAllele, allele);
}

//Increments m_NumTypeOffspring by one
void Offspring::updateNumType()
{
	m_iNumTypeOffspring++;
}

int Offspring::getNumTypeOffspring()
{
	return m_iNumTypeOffspring;
}

char *Offspring::getAllele()
{
	char *pass;
	pass = m_cAllele;
	return pass;
}