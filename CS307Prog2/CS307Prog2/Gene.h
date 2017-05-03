//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Gene.h
// Author: Cray L. Pella
// Description: Gene.h/.cpp is used to represent a gene on a chromosome
//				strand.
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include <iostream>
using namespace std;
#include "MasterGene.h"
#pragma once

class Gene
{
private:
	char m_cAlleleSym;
	int m_iDomOrRec;
	MasterGene *m_pRef;
	void setDomOrRec();

public:
	Gene(char sym);
	~Gene();
	void setRef(MasterGene *mgRef);
	MasterGene *getRef();
	char getAlleleSym();
	char *getAlleleDesc();
};