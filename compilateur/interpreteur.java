import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public class interpreteur {
	public static ArrayList<Integer> pile = new ArrayList<Integer>();
	public static int r0;
	public static int r1;
	public static int sp = -1;
	public static int bp = 0;
	public static Boolean conti = true;
	public static int index  = 0;
	public static int var(String s) throws Exception {
		switch (s) {
			case "r0":
				return r0;
			case "r1":
					return r1;
			case "bp":
					return bp;
			default:
					throw new Exception("mauvaise PUSHR");
		}	
	}
	public static int loadvar(String s) {
		switch(s) {
			case "r0":
				return r0;
			case "r1":
				return r1;
			case "sp":
					return pile.get(sp);
			case "bp":
					return pile.get(bp);
			default:
					if (s.contains("+")) {
						//System.out.println(s);
						String[] words = s.split("\\+");
						if (words[0].equals("sp")) {
							return pile.get(sp+Integer.parseInt(words[1]));
						}
						else {
							return pile.get(bp+Integer.parseInt(words[1]));
						}
					}
					else {
						//System.out.println(s);
						String[] words = s.split("-");
						if (words[0].equals("sp")) {
							return pile.get(sp-Integer.parseInt(words[1]));
						}
						else {
							return pile.get(bp-Integer.parseInt(words[1]));
						}
					}
		}
	}
	public static int storevar(String s) {
		switch(s) {
			case "sp":
					return sp;
			case "bp":
					return bp;
			default:
					if (s.contains("+")) {
						//System.out.println(s);
						String[] words = s.split("\\+");
						if (words[0].equals("sp")) {
							return sp+Integer.parseInt(words[1]);
						}
						else {
							return bp+Integer.parseInt(words[1]);
						}
					}
					else {
						String[] words = s.split("-");
						if (words[0].equals("sp")) {
							return sp-Integer.parseInt(words[1]);
						}
						else {
							return bp-Integer.parseInt(words[1]);
						}
					}
		}
	}
	public static void switchOP(String[] words) throws Exception {
		switch (words[0]) {
			case "PUSHR":
				sp++;
				pile.set(sp, var(words[1]));
				index++;
				break;
			case "PUSHSP":
				int aux = sp;
				sp++;
				pile.set(sp, aux);
				index++;
				break;
			case "PUSHV":
				sp++;
				pile.set(sp, Integer.parseInt(words[1]));
				index++;
				break;
			case "POP":
				switch(words[1]) {
					case "r0":
						r0 = pile.get(sp);
						sp--;
						index++;
						break;
					case "r1":
						r1 = pile.get(sp);
						sp--;
						index++;
						break;
					case "sp":
						sp = pile.get(sp);
						index++;
						break;
					case "bp":
						bp = pile.get(sp);
						sp--;
						index++;
						break;
				}
				break;
			case "LOADSP":
				//System.out.println("load \n");
				switch(words[1]) {
				case "r0":
					r0 = loadvar(words[2]);
					index++;
					break;
				case "r1":
					r1 = loadvar(words[2]);
					index++;
					break;
				case "sp":
					sp = loadvar(words[2]);
					index++;
					break;
				case "bp":
					bp = loadvar(words[2]);
					index++;
					break;
				}
				break;
			case "LOADRET":
				//System.out.println("load \n");
				switch(words[1]) {
				case "r0":
					r0 = loadvar(words[2]);
					index++;
					break;
				case "r1":
					r1 = loadvar(words[2]);
					index++;
					break;
				case "sp":
					sp = loadvar(words[2]);
					index++;
					break;
				case "bp":
					bp = loadvar(words[2]);
					index++;
					break;
				}
				break;
			case "LOADBP":
				//System.out.println("load \n");
				switch(words[1]) {
				case "r0":
					r0 = loadvar(words[2]);
					index++;
					break;
				case "r1":
					r1 = loadvar(words[2]);
					index++;
					break;
				case "sp":
					sp = loadvar(words[2]);
					index++;
					break;
				case "bp":
					bp = loadvar(words[2]);
					index++;
					break;
				}
				break;
			case "STORE":
				int ind= storevar(words[1]);
				switch(words[2]) {
				case "r0":
					pile.set(ind, r0);
					index++;
					break;
				case "r1":
					pile.set(ind, r1);
					index++;
					break;
				case "sp":
					pile.set(ind, sp);
					index++;
					break;
				case "bp":
					pile.set(ind, bp);
					index++;
					break;
				}
				break;
			case "JUMP":
				switch(words[1]) {
					case "r1":
						if (r1 == -1) {
							conti = false;
						}
						else {
							index = r1-1;
						}
						break;
					default :
						int  i = Integer.parseInt(words[1]);
						if (i==-1) {
							conti=false;
						}
						else {
							index = i-1;
						}
				}
			break;
			case "JUMPR":
				switch(words[1]) {
					case "r1":
						if (r1 == -1) {
							conti = false;
						}
						else {
							index = r1-1;
						}
						break;
					default :
						int  i = Integer.parseInt(words[1]);
						if (i==-1) {
							conti=false;
						}
						else {
							index = i-1;
						}
				}
			break;
			case "JUMPCOND":
				if (r0 == 1) {
					switch(words[1]) {
						case "r1":
							if (r1 == -1) {
								conti = false;
							}
							else {
								index = r1-1;
							}
							break;
						default :
							int  i = Integer.parseInt(words[1]);
							if (i==-1) {
								conti=false;
							}
							else {
								index = i-1;
							}
						}
				}
				else {
					index++;
				}
			break;
			case "JUMPNOTCOND":
				if (r0 == 0) {
					switch(words[1]) {
						case "r1":
							if (r1 == -1) {
								conti = false;
							}
							else {
								index = r1-1;
							}
							break;
						default :
							int  i = Integer.parseInt(words[1]);
							if (i==-1) {
								conti=false;
							}
							else {
								index = i-1;
							}
						}
				}
				else {
					index++;
				}
			break;
			case "ADD":
				r0 = r0+r1;
				index++;
				break;
			case "SUB":
				r0 = r0 - r1;
				index++;
				break;
			case "MUL":
				r0 = r0*r1;
				index++;
				break;
			case "EQ":
				if (r0 == r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "NE":
				if (r0 != r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "LT":
				if (r0 < r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "LE":
				if (r0 <= r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "GT":
				if (r0 > r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "GE":
				if (r0 >= r1) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "OR":
				if ((r0==1)|| (r1==1)) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "AND":
				if ((r0==1)&& (r1==1)) {
					r0 = 1;
				}
				else {
					r0 = 0;
				}
				index++;
				break;
			case "NOT":
				if (r0==1) {
					r0 = 0;
				}
				else {
					r0 = 1;
				}
				index++;
				break;
			default :
					
		}
	}
	public static void main(String[] args) throws Exception  {
		System.out.println("okay");
		List<String> listOfStrings= new ArrayList<String>();
		for (int i = 0; i < 256; i++) {
			  pile.add(-1);
			}
     // load data from file
     BufferedReader bf = new BufferedReader(
         new FileReader("textfiles/output.s"));
    
     // read entire line as string
     String line = bf.readLine();
    
     // checking for end of file
     while (line != null) {
         listOfStrings.add(line);
         line = bf.readLine();
     }
    
     // closing bufferreader object
     bf.close();
    
     // storing the data in arraylist to array
     String[] array = listOfStrings.toArray(new String[0]);
    
     // printing each line of file
     // which is stored in array
     for (String str : array) {
         System.out.println(str);
     }
     String str;
        pile.add(-1);
        pile.add(-1);
        pile.add(-1);
        pile.add(-1);
        bp = 3;
        sp = 3;
	    while (conti) {
	    	str = array[index];
	    	System.out.println("\n instruction : "+index+" - "+str);
	    	switchOP(str.split(" "));
	    	System.out.println("sp : "+sp);
	    	System.out.println("bp : "+bp);
	    	System.out.println("r0 : "+r0);
	    	System.out.println("r1 : "+r1);
	    	System.out.println(pile);
	    }
	    System.out.println(r0);
	}
}
