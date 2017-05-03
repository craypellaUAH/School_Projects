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
public class CS490Prog1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        MinHeap tester = new MinHeap(1000);
        
        Producer single = new Producer(tester);
        Consumer one = new Consumer(tester);
        Consumer two = new Consumer(tester);
        
        single.start();
        one.start();
        two.start();
        
     
    }
    
}
