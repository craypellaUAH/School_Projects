//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: GeneticsSim.cpp
// Author: Cray L. Pella
// Description: GeneticsSim.h/.cpp is used to manage and run the simulation
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "GeneticsSim.h"

GeneticsSim::GeneticsSim()
{
	srand((unsigned int)(time(NULL)));
	m_pPar = GeneticsSimDataParser::getInstance(); 
	userQuery();
}

GeneticsSim::~GeneticsSim()
{

}

GeneticsSim *GeneticsSim::getInstance()
{
	static GeneticsSim *theInstance = NULL;
	if(theInstance == NULL)
	{
		theInstance = new GeneticsSim();
	}
	return theInstance;
}

// Get file name to read data from and initialize data 
void GeneticsSim::userQuery()
{
	char filename[128];
	cout << "Enter a filename\n";
	cin >> filename;
	m_pPar->initDataFile(filename);
	readInData();
	displayGENE_PARENTINFO();
	getOffspringNum();
	startCross();
}

void GeneticsSim::getOffspringNum()
{
	cout << "How many offspring do you want to generate? (Type the number then press enter)\n";
	while(true)
	{
		cin >> m_iNumOff;
		if(cin.fail() || (m_iNumOff < 1) || (m_iNumOff > 1000))
		{
			cin.clear();
			cin.ignore(256,'\n');
			cout << "ERROR: Please enter a number between 1-1000 \n";
		}
		else
		{
			break;
		}
	}
}

void GeneticsSim::readInData()
{
	GeneFactory *gF = GeneFactory::getInstance();
	m_iNumGene = m_pPar->getGeneCount();

	//Set vector of MasterGene
	for(int x = 0; x < m_iNumGene; x++)
	{
		MasterGene *temp = gF->buildMasterGene();
		m_geneRef.push_back(temp);
	}

	OrganismFactory *oF = OrganismFactory::getInstance();

	Organism *parent1 = oF->buildOrganism();
	m_parents.push_back(parent1);

	Organism *parent2 = oF->buildOrganism();
	m_parents.push_back(parent2);

	int chroNum = m_pPar->getChromosomeCount();

	// Sets each Gene class's MasterGene Reference
	for(int y = 0; y < 2; y++)
	{
		for(int z = 0; z < chroNum; z++)
		{
			for(int w = 1; w < 3; w++)
			{
				int genes = m_parents.at(y)->getChromosome(z)->getGeneNum();
				for(int u = 0; u < genes; u++)
				{
					Gene *temp1 = m_parents.at(y)->getChromosome(z)->getGene(u, w);
					for(int x = 0; x < m_iNumGene; x++)
					{
						if((m_geneRef.at(x)->getDomSym()) == toupper(temp1->getAlleleSym()))
						{
							temp1->setRef(m_geneRef.at(x));
							break;
						}
					}

				}
			}
		}
	}

}

void GeneticsSim::displayGENE_PARENTINFO()
{
	int chroNum = m_pPar->getChromosomeCount();

	cout << "\nMaster Genes:\n";
	for(int z = 0; z < m_iNumGene; z++)
	{
		
		cout << "\tTrait Name: " << m_geneRef.at(z)->getGeneTrait() << endl;
		cout << "\t\tDominant Name: " << m_geneRef.at(z)->getDomAllele() << " (" << m_geneRef.at(z)->getDomSym() << ")\n";
		cout << "\t\tRecessive Name: " << m_geneRef.at(z)->getRecAllele() << " (" << m_geneRef.at(z)->getRecSym() << ")\n";
		cout << "\t\tChance of crossover: " << m_geneRef.at(z)->getCrossoverChance() << endl;
 	}

	for(int h = 0; h < 2; h++)
	{
		cout << "Sim parent " << h+1 << endl;
		cout << "\tOrganism genus-species: " << m_parents.at(h)->getScientificName() << endl;
		cout << "\tChromosomes:\n";
		for(int cN = 0; cN < chroNum; cN++)
		{
			cout << "\t\tChromosome " << cN+1 << endl;
			int gN = m_parents.at(h)->getChromosome(cN)->getGeneNum();
			for(int temp3 = 0; temp3 < gN; temp3++)
			{
				cout << "\t\t\tGene Type: " << m_parents.at(h)->getChromosome(cN)->getGene(temp3, 1)->getRef()->getGeneTrait() << endl;
				cout << "\t\t\t\tAllele 1: " <<  m_parents.at(h)->getChromosome(cN)->getGene(temp3, 1)->getAlleleDesc() << "("
					<<  m_parents.at(h)->getChromosome(cN)->getGene(temp3, 1)->getAlleleSym() << ")\n";
				cout << "\t\t\t\tAllele 2: " <<  m_parents.at(h)->getChromosome(cN)->getGene(temp3, 2)->getAlleleDesc() << "("
					<<  m_parents.at(h)->getChromosome(cN)->getGene(temp3, 2)->getAlleleSym() << ")\n";
			}
		}
	}
}

void GeneticsSim::startCross()
{
	MendelianCross *mC = MendelianCross::getInstance();

	mC->setGeneReference(&m_geneRef);
	mC->setGeneCount(m_iNumGene);

	mC->createOffspringVector();
	mC->startCross(m_iNumOff, m_parents.at(0), m_parents.at(1));

	m_children = mC->getOffspring();
	
	int crossed = mC->getTotalCrossed();
	int y = 0;
	cout << "============================= Results of this Run =============================\n\n";
	for(int x = 0; x < m_iNumGene; x++)
	{
		cout << "Gene: " << m_geneRef.at(x)->getGeneTrait() << endl;
		cout << "\t" << m_children->at(y)->getNumTypeOffspring() << " " <<
				m_children->at(y)->getGenotypeDesc() << " (" << m_geneRef.at(x)->
				getDomAllele() << " " <<  m_children->at(y)->getAllele() << ")\n";
		y++;
	
		cout << "\t" << m_children->at(y)->getNumTypeOffspring() << " " <<
				m_children->at(y)->getGenotypeDesc() << " (" << m_geneRef.at(x)->
				getDomAllele() <<  " " << m_children->at(y)->getAllele() << ")\n";
		y++;
	
		cout << "\t" << m_children->at(y)->getNumTypeOffspring() << " " <<
				m_children->at(y)->getGenotypeDesc() << " (" << m_geneRef.at(x)->
				getRecAllele() << " " << m_children->at(y)->getAllele() << ")\n\n";
		y++;	
	}

	cout << "A total of " << crossed << " offspring had at least one crossover gene.\n\n";
}

