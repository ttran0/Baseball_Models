import java.util.Scanner;

public class dice_pig {
	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in);
		int roll;
		int p1tot = 0;
		int p2tot = 0;
		int turn_total;
		String choice = "";

		do {
			// turn_total = 0;
			// System.out.println("You have " + turn_total + " points this round.");
			do {
				roll = 1 + (int) (Math.random() * 6);
				System.out.println("Player 1 rolled a " + roll + ".");
				if (roll == 1) {
					System.out.println("YOUR TURN ENDS!!!" );
					System.out.println();
					// turn_total = 0;
					p1tot = 0;
					break;
				}
				else {
					// turn_total += roll;
					p1tot += roll;
					// System.out.println("Player 1 has " + turn_total + " points this round");
					if(p1tot >= 20){
						break;
					}

					System.out.println("Player 1 has " + p1tot + " points.");
					System.out.println("Would you like to roll again or hold? ");
					choice = keyboard.next();
					System.out.println();

					}
				
				
			// } while (roll != 1 && choice.equals("roll") && p1tot < 20);
			   } while(choice.equals("roll"));
			// System.out.println("POINTS:" + p1tot);
			
			// p1tot += turn_total;
			System.out.println("Player 1 ends round with " + p1tot + " points.");
			System.out.println();

			if (p1tot >= 20){
				break;
			}


			System.out.println("NEXT PLAYERS TURN");
			System.out.println();


			do {
				roll = 1 + (int) (Math.random() * 6);
				System.out.println();
				System.out.println("Player 2 rolled a " + roll + ".");
				if (roll == 1) {
					System.out.println("YOUR TURN ENDS!!!");
					System.out.println();
					turn_total = 0;
					p2tot = 0;
					break;
				}

				else {
					// turn_total += roll;
					p2tot +=roll;
					// System.out.println("Player 2 has " + turn_total + " points this round");
					if(p2tot >= 20){
						break;
					}
					System.out.println("Player 2 has " + p2tot + " points");
					System.out.println("Would you like to roll again or hold? ");
					choice = keyboard.next();
					System.out.println();
				}

			} while (choice.equals("roll"));
			// p2tot += turn_total;
			
				
		System.out.println("Player 2 ends round with " + p2tot + " points.");
		System.out.println();

		} while(p1tot < 20 && p2tot < 20);
		

		if (p1tot > p2tot) {
			System.out.println("Player 1 wins");
		}
		else{
			System.out.println("Player 2 wins");
		}
	}
}