//--------------------------------------------------------------------------
// CS 307 Programming Assignment 2
// File: Gene.cpp
// Author: Cray L. Pella
// Description: Gene.h/.cpp is used to represent a gene on a chromosome
//				strand.
// Date: 03/28/17
//
// I attest that this program is entirely my own work
//--------------------------------------------------------------------------

#include "Gene.h"

Gene::Gene(char sym)
{
	m_cAlleleSym = sym;
	setDomOrRec();
}

Gene::~Gene()
{

}

void Gene::setDomOrRec()
{
	char temp = m_cAlleleSym;
	if(toupper(temp) == m_cAlleleSym)
	{
		m_iDomOrRec = 1;
	}
	else
	{
		m_iDomOrRec = 0;
	}
}

void Gene::setRef(MasterGene *mgRef)
{
	m_pRef = mgRef;
}

MasterGene *Gene::getRef()
{
	return m_pRef;
}

char Gene::getAlleleSym()
{
	return m_cAlleleSym;
}

char *Gene::getAlleleDesc()
{
	if(m_iDomOrRec == 0)
	{
		return m_pRef->getRecAllele();
	}
	else
	{
		return m_pRef->getDomAllele();
	}
}