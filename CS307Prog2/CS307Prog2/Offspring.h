//-------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Offspring.h
// Author: Cray L. Pella
// Description: Offspring.h/.cpp is used to represent a possible type of
//				offspring created from a Mendel Cross
// Date: 02/17/16
//
// I attest that this program is entirely my own work
//-------------------------------------------------------------------------

#include <iostream>
using namespace std;

#pragma once

class Offspring
{
private:
	char m_cAllele[3];
	int m_iNumTypeOffspring;
	char m_cGenotype[100];
public:
	Offspring();
	~Offspring();
	void setAllele(char *allele);
	void setGenotypeDesc(char *temp);
	char *getGenotypeDesc();
	void updateNumType();
	int getNumTypeOffspring();
	char *getAllele();
};
