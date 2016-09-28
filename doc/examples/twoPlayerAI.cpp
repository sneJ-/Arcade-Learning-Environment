/* *****************************************************************************
 * A.L.E (Arcade Learning Environment)
 * Copyright (c) 2009-2013 by Yavar Naddaf, Joel Veness, Marc G. Bellemare,
 *  Matthew Hausknecht, Marlos C. Machado and the Reinforcement Learning
 *  and Artificial Intelligence Laboratory
 * Released under the GNU General Public License; see License.txt for details. 
 *
 * Based on: Stella  --  "An Atari 2600 VCS Emulator"
 * Copyright (c) 1995-2007 by Bradford W. Mott and the Stella team
 *
 * *****************************************************************************
 *  twoPlayerAI.cpp 
 *
 *  Sample code for two random input AIs.
 *  Adapted by Jens Röwekamp, Luis Castro Leiva
 **************************************************************************** */

#include <iostream>
#include <ale_interface.hpp>

#ifdef __USE_SDL
  #include <SDL.h>
#endif

using namespace std;

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " rom_file" << std::endl;
        return 1;
    }

    ALEInterface ale;

    // Get & Set the desired settings
    ale.setInt("random_seed", 123);
    //The default is already 0.25, this is just an example
    ale.setFloat("repeat_action_probability", 0.25);

    // Display output?
    ale.setBool("display_screen", true);
    ale.setBool("sound", true);

    // Load the ROM file. (Also resets the system for new settings to
    // take effect.)
    ale.loadROM(argv[1]);

    // Get the vector of legal actions
    ActionVect legal_actions = ale.getLegalActionSet();
    ActionVect legal_actionsB = ale.getLegalActionSetB();

    // Play 10 episodes
    for (int i = 0; i < 10; i++){
	ale.setMode(1);
        
        float totalReward = 0;
        while (!ale.game_over()) {
            Action a = legal_actions[rand() % legal_actions.size()];
	    Action b = legal_actionsB[rand() % legal_actionsB.size()];
            // Apply the action and get the resulting reward
            float reward = ale.actAB(a,b);
            if(reward != 0){
                cout << "Reward: " << reward << endl;
            }
            totalReward += reward;
         }
         cout << "Episode ended with score: " << totalReward << endl;
         ale.reset_game();
    }

    return 0;
}
