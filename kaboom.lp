

entity(bomber).
entity(basket).
entity(bomb).

singular(bomber).
singular(basket).
many(bomb).

player_controls(basket).

resource(score).
resource(bombsperlevel).
resource(bombsleft).

resource(lives).
resource(bomber,duration).
resource(bomber,direction).
resource(bomber,timetilnextbomb).
resource(paused).

timerlogic(bomber,change_direction,duration,loop).

precondition(eq(paused,false),change_direction(bomber)).
precondition(timer_elapsed(bomber,change_direction), change_direction(bomber)).
result(change_direction(bomber), set(direction,random_choice(east,west))).

timerlogic(bomber,throw_bomb,timetilnextbomb,loop).
precondition(eq(paused,false),throw_bomb(bomber)).
precondition(timer_elapsed(bomber,throw_bomb), throw_bomb(bomber)).
result(throw_bomb(bomber), add(bomb)).
result(throw_bomb(bomber), decrease(bombsleft,low)).

precondition(eq(paused,false),tick).
result(tick, moves(bomber,direction)).
result(tick, moves(bomb,south)).

precondition(overlaps(bomb,basket),defuse).
result(defuse,delete(bomb)).
result(defuse,increase(score,low)).


precondition(control_event(player_input(right_arrow,held)),move_right).
result(move_right,moves(basket,  east , low)).

precondition(control_event(player_input(left_arrow,held)),move_left).
result(move_left,moves(basket,  west , low)).


precondition(overlaps(bomb,screen_bottom),lose_life).
result(lose_life,decrease(lives,low)).
result(lose_life,set(paused,true)).

precondition(le(lives,0),lose).
result(lose, mode_change(game_loss)).

