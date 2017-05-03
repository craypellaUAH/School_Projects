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
public class Producer extends Thread{
    
    MinHeap m_holder;
    
    public Producer(MinHeap temp)
    {
        m_holder = temp;
    }
    
    private void Produce()
    {
       // System.out.println("called");
        Node a = new Node((int )(Math.random()*10), (int )(Math.random()*10000+1));
        m_holder.AddNode(a);
         try{
            this.sleep((int)(Math.random()*4000));
           // System.out.println("sleeping");
        }
        catch(Exception e)
        {
             System.out.println("Error: Attempt to sleep failed."); 
        }
        this.Produce();
    }
    
    public void run()
    {
        this.Produce();
       
    }
}
