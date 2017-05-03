//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Chromosome.cpp
// Author: Cray L. Pella
// Description: Chromosome.h/.cpp is used to represent a chromosome composed 
//				of two strands containing genes. 
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "Chromosome.h"

Chromosome::Chromosome()
{
	m_iNumGene = 0;
	m_bCrossed = false;
}

Chromosome::~Chromosome()
{

}

void Chromosome::addGene(Gene *ref, int strandNum)
{
	if(strandNum == 1)
	{
		m_iNumGene++;
		m_geneReferenceStrand1.push_back(ref);
	}
	else
	{
		m_geneReferenceStrand2.push_back(ref);
	}
}

Gene *Chromosome::getGene(int location, int strandNum)
{
	if(strandNum == 1)
	{
		return m_geneReferenceStrand1.at(location);
	}
	else
	{
		return m_geneReferenceStrand2.at(location);
	}
}


// Creates and returns a chromosome strand
char *Chromosome::buildChromosomeStrand()
{
	char *strand;
	char temp[128];
	
	// For every gene pair in the chromosome
	for(int x = 0;x<m_iNumGene;x++)
	{
		// 50/50 chance to get either gene
		int y = rand()%2;

		// Apply crossover chance
		double z = (rand()%100) + 1;
		double w = m_geneReferenceStrand1.at(x)->getRef()->getCrossoverChance();

		// If crossover occurs
		if(z <= w)
		{
			m_bCrossed = true;
			y--;
			y*=-1;
		}

		if(y == 0)
		{
			temp[x] = m_geneReferenceStrand1.at(x)->getAlleleSym();
		}
		else
		{
			temp[x] = m_geneReferenceStrand2.at(x)->getAlleleSym();
		}
	}
	temp[127] = '\0';

	strand = temp;

	return strand;
}

int Chromosome::getGeneNum()
{
	return m_iNumGene;
}

bool Chromosome::getm_bCrossed()
{
	bool temp = m_bCrossed;
	m_bCrossed = false;
	return temp;
}