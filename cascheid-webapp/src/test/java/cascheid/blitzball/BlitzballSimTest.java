package cascheid.blitzball;

import static org.junit.Assert.*;

import org.junit.Test;

public class BlitzballSimTest {

	@Test
	public void testSimGame(){
		BlitzballGame game = BlitzballUtils.simulateGame(new BlitzballGame(BlitzballMockData.getTeam1(), BlitzballMockData.getTeam2()));
		assertNotNull(game);
		assertNotNull(game.getPlayerStatistics());
		assertNotEquals(game.getPlayerStatistics().size(), 0);
		int sumShots=0;
		int sumGoals=0;
		int sumBreaks=0;
		int sumBlocks=0;
		int sumTackles=0;
		int sumTurnovers=0;
		for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
			sumShots+=stats.getShots();
			sumGoals+=stats.getGoals();
			sumBreaks+=stats.getBreaks();
			sumBlocks+=stats.getBlocks();
			sumTackles+=stats.getTackles();
			sumTurnovers+=stats.getTurnovers();
			System.out.println("Player " + stats.getPlayerID() + " exp:" + stats.getExpGained() + "  shots:" + stats.getShots() + "  goals:" + stats.getGoals() + "  blocks:" + stats.getBlocks() + "  breaks:" + stats.getBreaks() + "  tackles:" + stats.getTackles() + "  shotsAgainst:" + stats.getShotsAgainst() + "  numTechsLearned:" + stats.getTechsLearned().size());
		}
		System.out.println(sumShots + " Shots");
		System.out.println(sumGoals + " Goals");
		System.out.println(sumBreaks + " Breaks");
		System.out.println(sumBlocks + " Blocks");
		System.out.println(sumTackles + " Tackles");
		System.out.println(sumTurnovers + " Turnovers");
		assertEquals(game.getHalvesComplete(), (Integer)2);
	}
}
