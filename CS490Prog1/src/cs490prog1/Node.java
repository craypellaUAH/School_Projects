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
public class Node 
{
    private int i_id;
    private int i_priority;
    private int i_timeSlice;
    private Node m_left;
    private Node m_right;
    
    public Node(int tempPriority, int tempTime)
    {
        i_priority = tempPriority;
        i_timeSlice = tempTime; 
        m_left = null;
        m_right = null;
    }
    
    public void SetID(int tempID)
    {
        i_id = tempID;
    }
    
    public int GetID()
    {
      return i_id;
    }
    
    public int GetPriority()
    {
        return i_priority;
    }
    
    public int GetTimeSlice()
    {
        return i_timeSlice;
    }
    
    public void SetLeft(Node temp)
    {
        m_left = temp;
    }
    
    public void SetRight(Node temp)
    {
        m_right = temp;
    }
    
    public Node GetLeft()
    {
       return m_left;
    }
    
    public Node GetRight()
    {
       return m_right;
    }
}

