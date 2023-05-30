import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

public class hexatranslator {
    private static String getTwoDigitHexString(int integer) {

        StringBuilder sb = new StringBuilder();
        sb.append(Integer.toHexString(integer));
        if (sb.length() < 2) {
            sb.insert(0, '0'); // pad with leading zero if needed
        }

        return sb.toString();

    }
	public static void main(String[] args) throws Exception  {
	     // load data from file
         String currentPath = new java.io.File(".").getCanonicalPath();
	     BufferedReader bf = new BufferedReader(
	         new FileReader(currentPath+"/output.s"));
	     List<String> listOfStrings= new ArrayList<String>();
	     // read entire line as string
	     String line = bf.readLine();
	    
	     // checking for end of file
	     while (line != null) {
	         listOfStrings.add(line);
	         line = bf.readLine();
	     }
	     bf.close();
	     BufferedWriter writer = new BufferedWriter(new FileWriter(currentPath+"/output"));
	     
	     // storing the data in arraylist to array
	     String[] array = listOfStrings.toArray(new String[0]);
	     for (String ligne : array) {
	    	 String[] mot = ligne.split(" ");
	    	 switch(mot[0]) {
	    		 case "JUMP":
	    		     writer.write("x\"0014"+getTwoDigitHexString(Integer.parseInt(mot[1]))+"00\", \n");
	    		     break;
	    		 case "JUMPR":
	    			 //adresse de r1 = 1
	    		     writer.write("x\"00180100\", \n"); 
	    		     break;
	    		 case "JUMPCOND":
	    		     writer.write("x\"0015"+getTwoDigitHexString(Integer.parseInt(mot[1]))+"00\", \n");
	    		     break;
	    		 case "JUMPNOTCOND":
	    		     writer.write("x\"0016"+getTwoDigitHexString(Integer.parseInt(mot[1]))+"00\", \n");
	    		     break;
	    		 case "ADD":
	    		     writer.write("x\"00010001\", \n"); 
	    		     break;
	    		 case "SUB":
	    		     writer.write("x\"00020001\", \n"); 
	    		     break;
	    		 case "MUL":
	    		     writer.write("x\"00030001\", \n"); 
	    		     break;
	    		 case "EQ":
	    		     writer.write("x\"00040001\", \n"); 
	    		     break;
	    		 case "NEQ":
	    		     writer.write("x\"00050001\", \n"); 
	    		     break;
	    		 case "AND":
	    		     writer.write("x\"00060001\", \n"); 
	    		     break;
	    		 case "OR":
	    		     writer.write("x\"00070001\", \n"); 
	    		     break;
	    		 case "LT":
	    		     writer.write("x\"00080001\", \n"); 
	    		     break;
	    		 case "GT":
	    		     writer.write("x\"00090001\", \n"); 
	    		     break;
	    		 case "LE":
	    		     writer.write("x\"000A0001\", \n"); 
	    		     break;
	    		 case "GE":
	    		     writer.write("x\"000B0001\", \n"); 
	    		     break;
	    		 case "NOT":
	    		     writer.write("x\"000C0001\", \n"); 
	    		     break;
	    		 case "POP":
	    		     if (mot[1] == "r0"){
	    		    	 writer.write("x\"000D0000\", \n");
	    			 }
	    			 else if (mot[1] == "r1"){
	    				 writer.write("x\"010D0000\", \n");
	    			 }
	    			 else if (mot[1] == "bp"){
	    				 writer.write("x\"020D0000\", \n");
	    			 }
	    		     break;
	    		 case "PUSHV":
	    		     writer.write("x\"000E"+getTwoDigitHexString(Integer.parseInt(mot[1]))+"00\", \n");
	    		     break;
	    		 case "PUSHR":
	    			 if (mot[1] == "r1"){
	    				 writer.write("x\"000F0000\", \n");
	    			 }else if (mot[1] == "r1") {
	    				 writer.write("x\"010F0000\", \n");
	    			 }else if (mot[1] == "bp") {
	    				 writer.write("x\"020F0000\", \n");
	    			 }
	    		     break;
	    		 case "PUSHSP":
	    		     writer.write("x\"00100000\", \n");
	    		     break;
	    		 case "LOADBP":
	    			if (mot[1] == "r1"){
	    				 writer.write("x\"01110002\", \n");
	    			 }
	    			 else if (mot[1] == "bp"){
	    				 writer.write("x\"02110102\", \n");
	    			 }
	    		     break;
	    		 case "LOADSP":
	    			 String dec = getTwoDigitHexString(Integer.parseInt((mot[2].split("-"))[1]));
	    		     writer.write("x\"0012"+dec+"00\", \n");
	    		     break;
	    		 case "STORE":
	    			 String dec2 = getTwoDigitHexString(Integer.parseInt((mot[1].split("-"))[1]));
	    		     writer.write("x\""+dec2+"130000\", \n");
	    		     break;
	    		 case "LOADRET":
	    		     writer.write("x\"00170102\", \n");
	    		     break;
	    		 default :
	    	 }
	     }
	     writer.close();
         System.out.println("");
         System.out.println("--------------------------------------------------------------------");
         System.out.println("Cible Assembleur \"output.s\" convertie en cible hexa décimale \"output\"");
         System.out.println("--------------------------------------------------------------------");
         System.out.println("");
     }
}

