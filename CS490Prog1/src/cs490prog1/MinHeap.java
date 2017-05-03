/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs490prog1;


/**
 *
 * @author craypella
 */
public class MinHeap {
    
    private int i_maxSize;
    private Node[] m_Heap;
    private int i_numItems;
    
    public MinHeap(int temp_maxSize)
    {
        i_maxSize = temp_maxSize;
        i_numItems = 0;
        m_Heap = new Node[i_maxSize];
    }
    
    private void RemoveFixHeap(int temp_head, int temp_tail)
    {
        Node temp_hold;
        int i_priorityLeaf;
        int i_leftLeaf = temp_head*2+1;
        int i_rightLeaf = temp_head*2+2;
       //System.out.println(m_Heap[i_leftLeaf].GetPriority() + "- Left Right-"
         //      + m_Heap[i_rightLeaf].GetPriority());
        
        if(i_leftLeaf <= temp_tail)
        {
            if(i_leftLeaf == temp_tail)
            {
                i_priorityLeaf = i_leftLeaf;
            }
            else
            {
                if(m_Heap[i_leftLeaf].GetPriority() >= m_Heap[i_rightLeaf].GetPriority())
                {
                    i_priorityLeaf = i_rightLeaf;
                }
                else
                {
                    i_priorityLeaf = i_leftLeaf;
                }
            }
            if(m_Heap[temp_head].GetPriority() > m_Heap[i_priorityLeaf].GetPriority())
            {
              temp_hold = m_Heap[temp_head];
              m_Heap[temp_head] = m_Heap[i_priorityLeaf];
              m_Heap[i_priorityLeaf] = temp_hold;
              RemoveFixHeap(i_priorityLeaf, temp_tail);
            }
        }
    }
    
    private void AddFixHeap(int temp_head, int temp_tail)
    {  
        Node temp_hold;
        int i_parent;
        
        if(temp_tail > temp_head)
        {
            i_parent = (temp_tail - 1)/2;
            if(m_Heap[i_parent].GetPriority() > m_Heap[temp_tail].GetPriority())
            {
                temp_hold = m_Heap[i_parent];
                m_Heap[i_parent] = m_Heap[temp_tail];
                m_Heap[temp_tail] = temp_hold;
                AddFixHeap(temp_head, i_parent);
            }
            
        }
    }
    
    public void AddNode(Node temp)
    {
        if(i_numItems < i_maxSize)
        {
            m_Heap[i_numItems] = temp;
            m_Heap[i_numItems].SetID(i_numItems);
            AddFixHeap(0, i_numItems);
            i_numItems++;
        }
    }
    
    public synchronized Node RemoveNode()
    {
        this.PrintHeap();
       if(i_numItems != 0)
       {
        Node temp_hold = new Node(m_Heap[0].GetPriority(), m_Heap[0].GetTimeSlice());
        temp_hold.SetID(m_Heap[0].GetID());
        i_numItems--;
        m_Heap[0] = m_Heap[i_numItems];
        RemoveFixHeap(0, i_numItems-1);
        return temp_hold;
        
       }else{
           return null;
       }
       
       
        
    }
    
    public void PrintHeap()
    {
        for(int temp = 0; temp < i_numItems; temp++)
        {
            System.out.println("Node " + temp + ". ID " + m_Heap[temp].GetID() 
                    + ". Priority= " + m_Heap[temp].GetPriority());
        }
        
    }
}
