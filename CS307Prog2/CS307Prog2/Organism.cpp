//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Organism.cpp
// Author: Cray L. Pella
// Description: Organism.h/.cpp is used to represent a parent organism
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "Organism.h"

Organism::Organism(char *temp1, char *temp2, char *temp3, char *temp4)
{
	strcpy(m_cGenus, temp1);
	strcpy(m_cSpecies, temp2);
	strcpy(m_cScientificName, temp3);
	strcpy(m_cCommonName, temp4);
	m_iChromosomeNum = 0;
}

Organism::~Organism()
{

}

void Organism::addChromosome(Chromosome *temp)
{
	m_iChromosomeNum++;
	m_chroRef.push_back(temp);
}

Chromosome *Organism::getChromosome(int location)
{
	return m_chroRef.at(location);
}

char *Organism::getGenus()
{
	char *temp;
	temp = m_cGenus;
	return temp;

}

char *Organism::getSpecies()
{
	char *temp;
	temp = m_cSpecies;
	return temp;
}

char *Organism::getCommonName()
{
	char *temp;
	temp = m_cCommonName;
	return temp;
}

char *Organism::getScientificName()
{
	char *temp;
	temp = m_cScientificName;
	return temp;
}

int Organism::getChromosomeNum()
{
	return m_iChromosomeNum;
}