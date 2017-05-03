/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs490prog1;
import java.util.Date;
/**
 *
 * @author craypella
 */
public class Consumer extends Thread{
    
    MinHeap m_holder;
    
    
    
    public Consumer(MinHeap temp)
    {
        m_holder = temp;
        
        
    }
    
    private void RetrieveProcess()
    {
        Node temp = m_holder.RemoveNode();
        if(temp != null){
            boolean work;
            try{
                  
                this.sleep(temp.GetTimeSlice());
                work = true;
            }
            catch(Exception e)
            {
                System.out.println("Error: Attempt to sleep failed."); 
                work = false;  
            }
            if(work)
            {
                System.out.println("Process ID: " + temp.GetID() + ". Process Priority: " + 
                temp.GetPriority() + ". Time: " + this.timeFunc() + " milliseconds");
                System.out.println(this.getName());
                this.RetrieveProcess();
            }
            else
            {
                try{
                    this.sleep(5000);
                }
                catch(Exception e)
                {
                   System.out.println("Error: Attempt to sleep failed."); 
                }
            this.RetrieveProcess();
            }   
        }
        else
        {
            try{
                this.sleep(5000);
            }
            catch(Exception e)
            {
                   System.out.println("Error: Attempt to sleep failed."); 
            } 
            this.RetrieveProcess();
        }
    }
    
    public void run()
    {
        this.RetrieveProcess();   
    }
    
    private long timeFunc()
    {
       Date timer = new Date();
       return timer.getTime();
    }
}
