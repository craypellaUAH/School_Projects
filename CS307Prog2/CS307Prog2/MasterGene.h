//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: MasterGene.h
// Author: Cray L. Pella
// Description: MasterGene.h/.cpp is used to represent all data defining a 
//				particular gene
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
using namespace std;

#pragma once

class MasterGene
{
private:
	char m_cGeneTrait[128];
	char m_cDomAllele[128];
	char m_cDomSym;
	char m_cRecAllele[128];
	char m_cRecSym;
	double m_dCrossoverChance;

public:
	MasterGene(char *gT, char *dA, char *dS, char *rA, char *rS, double *cC);
	~MasterGene();
	char *getGeneTrait();
	char *getDomAllele();
	char getDomSym();
	char *getRecAllele();
	char getRecSym();
	double getCrossoverChance();

};