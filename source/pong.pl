:- set(posonly)?
:- modeh(*,player_controls(+entity)).
:- modeb(*,precondition(+condition,+outcome)).
:- modeb(*,result(+outcome,+action)).

player_controls(paddle_player).

condition(X) :- precondition(X,_).
outcome(O) :- precondition(_,O).
action(A) :- result(_,A).



type(boolean,boolean).
type(boolean,false).
type(boolean,true).
type(boundary,boundary).
type(boundary,screen_left).
type(boundary,screen_right).
type(direction,direction).
type(direction,north).
type(direction,north_east).
type(direction,north_west).
type(direction,vector).
type(direction,south).
type(entity,ball).
type(entity,entity).
type(entity,paddle_computer).
type(entity,paddle_player).
type(key,down_arrow).
type(key,key).
type(key,space).
type(key,up_arrow).
type(mode,game_loss).
type(mode,game_win).
type(mode,mode_change).
type(outcome,computer_hit).
type(outcome,computer_score).
type(outcome,computer_serve).
type(outcome,lose).
type(outcome,move_down).
type(outcome,move_down_computer).
type(outcome,move_up).
type(outcome,move_up_computer).
type(outcome,outcome).
type(outcome,player_hit).
type(outcome,player_score).
type(outcome,player_serve).
type(outcome,win).
type(press_type,held).
type(press_type,pressed).
type(press_type,press_type).
type(resource,computer_start).
type(resource,player_start).
type(resource,resource).
type(resource,score_computer).
type(resource,score_player).
type(scalar,high).
type(scalar,low).
type(scalar,scalar).
type(entity,singular).
type(control_event,player_input).
type(control_event,control_event).

entity(ball).
entity(paddle_player).
entity(paddle_computer).

singular(ball).
singular(paddle_player).
singular(paddle_computer).

resource(score_player).
resource(score_computer).

resource(player_start).
resource(computer_start).

precondition(eq(player_start,true),player_serve).
precondition(control_event(player_input(space,pressed)),player_serve).
result(player_serve, set(player_start,false)).
result(player_serve,apply_impulse(ball, vector(north_east))).


precondition(eq(computer_start,true),computer_serve).
result(computer_serve, set(computer_start,false)).
result(computer_serve,apply_impulse(ball, vector(north_west))).


precondition(control_event(player_input(up_arrow,held)),move_up).
result(move_up,moves(paddle_player,  north , low)).

precondition(control_event(player_input(down_arrow,held)),move_down).
result(move_down,moves(paddle_player,  south , low)).

precondition(above(paddle_computer,ball), move_up_computer).
result(move_up_computer,moves(paddle_computer,  north , low)).

precondition(below(paddle_computer,ball),move_down_computer).
result(move_down_computer,moves(paddle_computer,  south , low)).

precondition(overlaps(ball,screen_left),computer_score).
result(computer_score,set(player_start,true)).
result(computer_score,increase(score_computer,low)).

precondition(overlaps(ball,paddle_computer),computer_hit).
result(computer_hit,reflect_velocity(ball,collision_normal(ball,paddle_computer))).


precondition(overlaps(ball,paddle_player),player_hit).
result(player_hit,reflect_velocity(ball,collision_normal(ball,player_hit))).

precondition(overlaps(ball,screen_right),player_score).
result(player_score,set(player_start,true)).
result(player_score,increase(score_player,low)).


precondition(ge(score_player,high),win).
result(win, mode_change(game_win)).

precondition(ge(score_computer,high), lose).
result(lose, mode_change(game_loss)).

player_controls(Ventity3) :-
	precondition(control_event(player_input(Vkey2,Vpress_type0)),Voutcome5) ,
	result(Voutcome5,moves(Ventity3,Vdirection4,Vscalar1)).
