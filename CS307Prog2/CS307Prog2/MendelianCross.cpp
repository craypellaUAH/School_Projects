//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: MendelianCross.cpp
// Author: Cray L. Pella
// Description: MendelianCross.h/.cpp is used to perform a Mendelian cross
//				between two organisms
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "MendelianCross.h"

MendelianCross::MendelianCross()
{
	m_iTotalCrossed = 0;
}

MendelianCross::~MendelianCross()
{

}

MendelianCross *MendelianCross::getInstance()
{
	static MendelianCross *theInstance = NULL;
	if(theInstance == NULL)
	{
		theInstance = new MendelianCross();
	}
	return theInstance;
}

//Creates a vector containing Offspring
void MendelianCross::createOffspringVector()
{
	char *holdAllelePair;
	char genotypeDesc[128];
	char allelePair[3];

	holdAllelePair = allelePair;
	Offspring *hold;
	for(int y = 0; y < m_iNumGene; y++)
	{
		hold = new Offspring();
		strcpy(genotypeDesc, "Homozygous Dominant");
		hold->setGenotypeDesc(genotypeDesc);
		allelePair[0] = m_geneReference->at(y)->getDomSym();
		allelePair[1] = m_geneReference->at(y)->getDomSym();	
		allelePair[2] = '\0';
		hold->setAllele(holdAllelePair);
		m_children.push_back(hold);

		hold = new Offspring();
		strcpy(genotypeDesc, "Heterozygous Dominant");
		hold->setGenotypeDesc(genotypeDesc);
		allelePair[0] = m_geneReference->at(y)->getDomSym();
		allelePair[1] = m_geneReference->at(y)->getRecSym();
		hold->setAllele(holdAllelePair);
		m_children.push_back(hold);
		
		hold = new Offspring();
		strcpy(genotypeDesc, "Homozygous Recessive");
		hold->setGenotypeDesc(genotypeDesc);
		allelePair[0] = m_geneReference->at(y)->getRecSym();
		allelePair[1] = m_geneReference->at(y)->getRecSym();
		hold->setAllele(holdAllelePair);
		m_children.push_back(hold);
	}
}

void MendelianCross::setGeneReference(vector<MasterGene *>* geneRef)
{
	m_geneReference = geneRef;
}

void MendelianCross::setGeneCount(int geneCount)
{
	m_iNumGene = geneCount;
}

vector<Offspring *> *MendelianCross::getOffspring()
{
	return &m_children;
}


//Searches the children vector and updates the amount of Offspring of that type
void MendelianCross::search_AddOffspring(char *pass)
{
	for(int x = 0; x < (m_iNumGene*3); x++)
	{
		if(((m_children.at(x)->getAllele())[0] == pass[0]) && ((m_children.at(x)->getAllele())[1] == pass[1]))
		{
			m_children.at(x)->updateNumType();
			break;
		}
	}
}

// Performs cross
void MendelianCross::startCross(int numOffspring, Organism *p1, Organism *p2)
{
	int chroCount = p1->getChromosomeNum();

	int geneNum;
	char *temp1;
	char strand1[128];
	temp1 = strand1;
	char *temp2;
	char strand2[128];
	temp2 = strand2;
	char allele[3];
	char hold[2];

	// Loop for every offspring
	for(int o = 0; o < numOffspring; o++)
	{
		int hadCross = false;
		// Loop for every chromosome in parent
		for(int x = 0; x < chroCount; x++)
		{
			strcpy(temp1, p1->getChromosome(x)->buildChromosomeStrand());
			strcpy(temp2, p2->getChromosome(x)->buildChromosomeStrand());
			geneNum = p1->getChromosome(x)->getGeneNum();
			
			if((p1->getChromosome(x)->getm_bCrossed()))
			{
				hadCross = true;
			}

			if((p2->getChromosome(x)->getm_bCrossed()))
			{
				hadCross = true;
			}

			// Loop for every gene pair in chromosome
			for(int y = 0; y < geneNum; y++)
			{
				allele[0] = strand1[y];
				allele[1] = strand2[y];

				// Set alleles in order, Dominant before Recessive
				if(allele[0] > allele[1])
				{
					hold[0] = allele[0];
					allele[0] = allele[1];
					allele[1] = hold[0];
				}
				allele[2] = '\0';
				char *holdAllele;
				holdAllele = allele;
				search_AddOffspring(holdAllele);
			}
		}

		if(hadCross)
		{
			m_iTotalCrossed++;
		}



	}
}

int MendelianCross::getTotalCrossed()
{
	return m_iTotalCrossed;
}