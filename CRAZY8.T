% ********** IDENTIFICATION **********
% Programmer: Dan Lynch
% Date: March 11, 1998
% File Name: crazy8.t

% ********** MAIN LINE **********

include "%scrnfl2.t"
include "tgui.t"

setscreen ("graphics:vga,nocursor,noecho")

% number and letter pictures
var black_ace_up, black_ace_dn, black_two_up, black_two_dn,
    black_three_up, black_three_dn, black_four_up, black_four_dn,
    black_five_up, black_five_dn, black_six_up, black_six_dn, black_seven_up,
    black_seven_dn, black_eight_up, black_eight_dn, black_nine_up,
    black_nine_dn, black_ten_up, black_ten_dn, black_jack_up, black_jack_dn,
    black_queen_up, black_queen_dn, black_king_up, black_king_dn,

    red_ace_up, red_ace_dn, red_two_up, red_two_dn, red_three_up,
    red_three_dn, red_four_up, red_four_dn, red_five_up, red_five_dn,
    red_six_up, red_six_dn, red_seven_up, red_seven_dn, red_eight_up,
    red_eight_dn, red_nine_up, red_nine_dn, red_ten_up, red_ten_dn,
    red_jack_up, red_jack_dn, red_queen_up, red_queen_dn, red_king_up,
    red_king_dn : array 1 .. sizepic (0, 0, 10, 15) of int

% big suit symbols
var big_spade_up, big_spade_dn, big_club_up, big_club_dn,
    big_diamond_up, big_diamond_dn, big_heart_up, big_heart_dn
    : array 1 .. sizepic (0, 0, 20, 25) of int

% small suit symbols
var small_diamond_up, small_diamond_dn, small_heart_up, small_heart_dn,
    small_spade_up, small_spade_dn, small_club_up, small_club_dn
    : array 1 .. sizepic (0, 0, 8, 10) of int

% face card plates
var jack_spade, jack_club, jack_diamond, jack_heart, queen_spade,
    queen_club, queen_diamond, queen_heart, king_spade, king_club,
    king_diamond, king_heart : array 1 .. sizepic (0, 0, 63, 99) of int

% card back
var back : array 1 .. sizepic (0, 0, 90, 130) of int

% positions of big suit symbols
var x_pos, y_pos, z_pos : array 1 .. 10, 1 .. 10 of int

% arrays for card-holding areas
var deck, discard : array - 3 .. 52 of int
var hand : array 1 .. 4, 0 .. 52 of int

var realsuit : int := 1 % the actual suit

var present := true % is the deck present

var reshuffle_option, pickup_2_option, crazy_8_option, change_8_option,
    jack_miss_option, pickup_5_option := true % options

% ********** LOAD DATA **********

proc loaddata
    % To load the position data into memory
    var pn : int
    open : pn, "position.dat", get
    for x : 1 .. 10
	for y : 1 .. x
	    get : pn, x_pos (x, y)
	    get : pn, y_pos (x, y)
	    get : pn, z_pos (x, y) % orientation
	end for
    end for
    close : pn
end loaddata

% ********** LOAD PICS **********

proc loadpics
    % To load the picture data into memory

    % red numbers/letters
    FileToScreen (0, 0, "images/value/rau.tm2")
    takepic (0, 0, 9, 14, red_ace_up)
    FileToScreen (0, 0, "images/value/rad.tm2")
    takepic (0, 0, 9, 14, red_ace_dn)
    FileToScreen (0, 0, "images/value/r2u.tm2")
    takepic (0, 0, 9, 14, red_two_up)
    FileToScreen (0, 0, "images/value/r2d.tm2")
    takepic (0, 0, 9, 14, red_two_dn)
    FileToScreen (0, 0, "images/value/r3u.tm2")
    takepic (0, 0, 9, 14, red_three_up)
    FileToScreen (0, 0, "images/value/r3d.tm2")
    takepic (0, 0, 9, 14, red_three_dn)
    FileToScreen (0, 0, "images/value/r4u.tm2")
    takepic (0, 0, 9, 14, red_four_up)
    FileToScreen (0, 0, "images/value/r4d.tm2")
    takepic (0, 0, 9, 14, red_four_dn)
    FileToScreen (0, 0, "images/value/r5u.tm2")
    takepic (0, 0, 9, 14, red_five_up)
    FileToScreen (0, 0, "images/value/r5d.tm2")
    takepic (0, 0, 9, 14, red_five_dn)
    FileToScreen (0, 0, "images/value/r6u.tm2")
    takepic (0, 0, 9, 14, red_six_up)
    FileToScreen (0, 0, "images/value/r6d.tm2")
    takepic (0, 0, 9, 14, red_six_dn)
    FileToScreen (0, 0, "images/value/r7u.tm2")
    takepic (0, 0, 9, 14, red_seven_up)
    FileToScreen (0, 0, "images/value/r7d.tm2")
    takepic (0, 0, 9, 14, red_seven_dn)
    FileToScreen (0, 0, "images/value/r8u.tm2")
    takepic (0, 0, 9, 14, red_eight_up)
    FileToScreen (0, 0, "images/value/r8d.tm2")
    takepic (0, 0, 9, 14, red_eight_dn)
    FileToScreen (0, 0, "images/value/r9u.tm2")
    takepic (0, 0, 9, 14, red_nine_up)
    FileToScreen (0, 0, "images/value/r9d.tm2")
    takepic (0, 0, 9, 14, red_nine_dn)
    FileToScreen (0, 0, "images/value/r10u.tm2")
    takepic (0, 0, 9, 14, red_ten_up)
    FileToScreen (0, 0, "images/value/r10d.tm2")
    takepic (0, 0, 9, 14, red_ten_dn)
    FileToScreen (0, 0, "images/value/rju.tm2")
    takepic (0, 0, 9, 14, red_jack_up)
    FileToScreen (0, 0, "images/value/rjd.tm2")
    takepic (0, 0, 9, 14, red_jack_dn)
    FileToScreen (0, 0, "images/value/rqu.tm2")
    takepic (0, 0, 9, 14, red_queen_up)
    FileToScreen (0, 0, "images/value/rqd.tm2")
    takepic (0, 0, 9, 14, red_queen_dn)
    FileToScreen (0, 0, "images/value/rku.tm2")
    takepic (0, 0, 9, 14, red_king_up)
    FileToScreen (0, 0, "images/value/rkd.tm2")
    takepic (0, 0, 9, 14, red_king_dn)

    % black numbers/letters
    FileToScreen (0, 0, "images/value/bau.tm2")
    takepic (0, 0, 9, 14, black_ace_up)
    FileToScreen (0, 0, "images/value/bad.tm2")
    takepic (0, 0, 9, 14, black_ace_dn)
    FileToScreen (0, 0, "images/value/b2u.tm2")
    takepic (0, 0, 9, 14, black_two_up)
    FileToScreen (0, 0, "images/value/b2d.tm2")
    takepic (0, 0, 9, 14, black_two_dn)
    FileToScreen (0, 0, "images/value/b3u.tm2")
    takepic (0, 0, 9, 14, black_three_up)
    FileToScreen (0, 0, "images/value/b3d.tm2")
    takepic (0, 0, 9, 14, black_three_dn)
    FileToScreen (0, 0, "images/value/b4u.tm2")
    takepic (0, 0, 9, 14, black_four_up)
    FileToScreen (0, 0, "images/value/b4d.tm2")
    takepic (0, 0, 9, 14, black_four_dn)
    FileToScreen (0, 0, "images/value/b5u.tm2")
    takepic (0, 0, 9, 14, black_five_up)
    FileToScreen (0, 0, "images/value/b5d.tm2")
    takepic (0, 0, 9, 14, black_five_dn)
    FileToScreen (0, 0, "images/value/b6u.tm2")
    takepic (0, 0, 9, 14, black_six_up)
    FileToScreen (0, 0, "images/value/b6d.tm2")
    takepic (0, 0, 9, 14, black_six_dn)
    FileToScreen (0, 0, "images/value/b7u.tm2")
    takepic (0, 0, 9, 14, black_seven_up)
    FileToScreen (0, 0, "images/value/b7d.tm2")
    takepic (0, 0, 9, 14, black_seven_dn)
    FileToScreen (0, 0, "images/value/b8u.tm2")
    takepic (0, 0, 9, 14, black_eight_up)
    FileToScreen (0, 0, "images/value/b8d.tm2")
    takepic (0, 0, 9, 14, black_eight_dn)
    FileToScreen (0, 0, "images/value/b9u.tm2")
    takepic (0, 0, 9, 14, black_nine_up)
    FileToScreen (0, 0, "images/value/b9d.tm2")
    takepic (0, 0, 9, 14, black_nine_dn)
    FileToScreen (0, 0, "images/value/b10u.tm2")
    takepic (0, 0, 9, 14, black_ten_up)
    FileToScreen (0, 0, "images/value/b10d.tm2")
    takepic (0, 0, 9, 14, black_ten_dn)
    FileToScreen (0, 0, "images/value/bju.tm2")
    takepic (0, 0, 9, 14, black_jack_up)
    FileToScreen (0, 0, "images/value/bjd.tm2")
    takepic (0, 0, 9, 14, black_jack_dn)
    FileToScreen (0, 0, "images/value/bqu.tm2")
    takepic (0, 0, 9, 14, black_queen_up)
    FileToScreen (0, 0, "images/value/bqd.tm2")
    takepic (0, 0, 9, 14, black_queen_dn)
    FileToScreen (0, 0, "images/value/bku.tm2")
    takepic (0, 0, 9, 14, black_king_up)
    FileToScreen (0, 0, "images/value/bkd.tm2")
    takepic (0, 0, 9, 14, black_king_dn)

    % spades
    FileToScreen (0, 0, "images/suit/sbu.tm2")
    takepic (0, 0, 19, 24, big_spade_up)
    FileToScreen (0, 0, "images/suit/sbd.tm2")
    takepic (0, 0, 19, 24, big_spade_dn)
    FileToScreen (0, 0, "images/suit/ssu.tm2")
    takepic (0, 0, 7, 9, small_spade_up)
    FileToScreen (0, 0, "images/suit/ssd.tm2")
    takepic (0, 0, 7, 9, small_spade_dn)

    % clubs
    FileToScreen (0, 0, "images/suit/cbu.tm2")
    takepic (0, 0, 19, 24, big_club_up)
    FileToScreen (0, 0, "images/suit/cbd.tm2")
    takepic (0, 0, 19, 24, big_club_dn)
    FileToScreen (0, 0, "images/suit/csu.tm2")
    takepic (0, 0, 7, 9, small_club_up)
    FileToScreen (0, 0, "images/suit/csd.tm2")
    takepic (0, 0, 7, 9, small_club_dn)

    % hearts
    FileToScreen (0, 0, "images/suit/hbu.tm2")
    takepic (0, 0, 19, 24, big_heart_up)
    FileToScreen (0, 0, "images/suit/hbd.tm2")
    takepic (0, 0, 19, 24, big_heart_dn)
    FileToScreen (0, 0, "images/suit/hsu.tm2")
    takepic (0, 0, 7, 9, small_heart_up)
    FileToScreen (0, 0, "images/suit/hsd.tm2")
    takepic (0, 0, 7, 9, small_heart_dn)

    % diamonds
    FileToScreen (0, 0, "images/suit/dbu.tm2")
    takepic (0, 0, 19, 24, big_diamond_up)
    FileToScreen (0, 0, "images/suit/dbd.tm2")
    takepic (0, 0, 19, 24, big_diamond_dn)
    FileToScreen (0, 0, "images/suit/dsu.tm2")
    takepic (0, 0, 7, 9, small_diamond_up)
    FileToScreen (0, 0, "images/suit/dsd.tm2")
    takepic (0, 0, 7, 9, small_diamond_dn)

    % jacks
    FileToScreen (0, 0, "images/plate/sj.tm2")
    takepic (0, 0, 62, 98, jack_spade)
    FileToScreen (0, 0, "images/plate/cj.tm2")
    takepic (0, 0, 62, 98, jack_club)
    FileToScreen (0, 0, "images/plate/hj.tm2")
    takepic (0, 0, 62, 98, jack_heart)
    FileToScreen (0, 0, "images/plate/dj.tm2")
    takepic (0, 0, 62, 98, jack_diamond)

    % queens
    FileToScreen (0, 0, "images/plate/sq.tm2")
    takepic (0, 0, 62, 98, queen_spade)
    FileToScreen (0, 0, "images/plate/cq.tm2")
    takepic (0, 0, 62, 98, queen_club)
    FileToScreen (0, 0, "images/plate/hq.tm2")
    takepic (0, 0, 62, 98, queen_heart)
    FileToScreen (0, 0, "images/plate/dq.tm2")
    takepic (0, 0, 62, 98, queen_diamond)

    % kings
    FileToScreen (0, 0, "images/plate/sk.tm2")
    takepic (0, 0, 62, 98, king_spade)
    FileToScreen (0, 0, "images/plate/ck.tm2")
    takepic (0, 0, 62, 98, king_club)
    FileToScreen (0, 0, "images/plate/hk.tm2")
    takepic (0, 0, 62, 98, king_heart)
    FileToScreen (0, 0, "images/plate/dk.tm2")
    takepic (0, 0, 62, 98, king_diamond)

    % card back
    FileToScreen (0, 0, "images/backgr~1/face.tm2")
    takepic (0, 0, 89, 129, back)
end loadpics

% ********** SUIT **********

function suit (card : int) : int
    % Returns the suit of a given card (1=Spades,2=Clubs,3=Hearts,4=Diamonds)
    result ceil (card / 13)
end suit

% ********** VALUE **********

function value (card : int) : int
    % Returns the value of a given card (1=Ace,11=Jack,12=Queen,13=King)
    result card - (suit (card) - 1) * 13
end value

% ********** SHOW CARD **********

proc showcard (x, y, card : int)
    % To draw a card on the screen at (x, y)

    % To draw the white box
    drawfillbox (x + 1, y + 1, x + 99, y + 139, 15) % inside

    % To draw the white lines
    drawline (x, y + 2, x, y + 138, 15) % left
    drawline (x + 2, y, x + 98, y, 15) % bottom
    drawline (x + 100, y + 2, x + 100, y + 138, 15) % right
    drawline (x + 2, y + 140, x + 98, y + 140, 15) % top

    % To draw the black lines
    drawline (x - 1, y + 2, x - 1, y + 138, 0) % left
    drawline (x + 2, y - 1, x + 98, y - 1, 0) % bottom
    drawline (x + 101, y + 2, x + 101, y + 138, 0) % right
    drawline (x + 2, y + 141, x + 98, y + 141, 0) % top

    % To blacken the corners
    drawline (x - 1, y + 2, x + 2, y - 1, 0) % bottom left
    drawline (x + 98, y - 1, x + 101, y + 2, 0) % bottom right
    drawline (x + 101, y + 138, x + 98, y + 141, 0) % top right
    drawline (x + 2, y + 141, x - 1, y + 138, 0) % top left

    if card > 0 then
	% To draw the numbers or letters
	if suit (card) = 1 or suit (card) = 2 then % black
	    case value (card) of
		label 1 : % ace
		    drawpic (x + 3, y + 119, black_ace_up, 0)
		    drawpic (x + 87, y + 6, black_ace_dn, 0)
		label 2 :
		    drawpic (x + 3, y + 119, black_two_up, 0)
		    drawpic (x + 87, y + 6, black_two_dn, 0)
		label 3 :
		    drawpic (x + 3, y + 119, black_three_up, 0)
		    drawpic (x + 87, y + 6, black_three_dn, 0)
		label 4 :
		    drawpic (x + 3, y + 119, black_four_up, 0)
		    drawpic (x + 87, y + 6, black_four_dn, 0)
		label 5 :
		    drawpic (x + 3, y + 119, black_five_up, 0)
		    drawpic (x + 87, y + 6, black_five_dn, 0)
		label 6 :
		    drawpic (x + 3, y + 119, black_six_up, 0)
		    drawpic (x + 87, y + 6, black_six_dn, 0)
		label 7 :
		    drawpic (x + 3, y + 119, black_seven_up, 0)
		    drawpic (x + 87, y + 6, black_seven_dn, 0)
		label 8 :
		    drawpic (x + 3, y + 119, black_eight_up, 0)
		    drawpic (x + 87, y + 6, black_eight_dn, 0)
		label 9 :
		    drawpic (x + 3, y + 119, black_nine_up, 0)
		    drawpic (x + 87, y + 6, black_nine_dn, 0)
		label 10 :
		    drawpic (x + 3, y + 119, black_ten_up, 0)
		    drawpic (x + 87, y + 6, black_ten_dn, 0)
		label 11 : % jack
		    drawpic (x + 3, y + 119, black_jack_up, 0)
		    drawpic (x + 87, y + 6, black_jack_dn, 0)
		label 12 : % queen
		    drawpic (x + 3, y + 119, black_queen_up, 0)
		    drawpic (x + 87, y + 6, black_queen_dn, 0)
		label 13 : % king
		    drawpic (x + 3, y + 119, black_king_up, 0)
		    drawpic (x + 87, y + 6, black_king_dn, 0)
	    end case
	else % red
	    case value (card) of
		label 1 : % ace
		    drawpic (x + 3, y + 119, red_ace_up, 0)
		    drawpic (x + 87, y + 6, red_ace_dn, 0)
		label 2 :
		    drawpic (x + 3, y + 119, red_two_up, 0)
		    drawpic (x + 87, y + 6, red_two_dn, 0)
		label 3 :
		    drawpic (x + 3, y + 119, red_three_up, 0)
		    drawpic (x + 87, y + 6, red_three_dn, 0)
		label 4 :
		    drawpic (x + 3, y + 119, red_four_up, 0)
		    drawpic (x + 87, y + 6, red_four_dn, 0)
		label 5 :
		    drawpic (x + 3, y + 119, red_five_up, 0)
		    drawpic (x + 87, y + 6, red_five_dn, 0)
		label 6 :
		    drawpic (x + 3, y + 119, red_six_up, 0)
		    drawpic (x + 87, y + 6, red_six_dn, 0)
		label 7 :
		    drawpic (x + 3, y + 119, red_seven_up, 0)
		    drawpic (x + 87, y + 6, red_seven_dn, 0)
		label 8 :
		    drawpic (x + 3, y + 119, red_eight_up, 0)
		    drawpic (x + 87, y + 6, red_eight_dn, 0)
		label 9 :
		    drawpic (x + 3, y + 119, red_nine_up, 0)
		    drawpic (x + 87, y + 6, red_nine_dn, 0)
		label 10 :
		    drawpic (x + 3, y + 119, red_ten_up, 0)
		    drawpic (x + 87, y + 6, red_ten_dn, 0)
		label 11 : % jack
		    drawpic (x + 3, y + 119, red_jack_up, 0)
		    drawpic (x + 87, y + 6, red_jack_dn, 0)
		label 12 : % queen
		    drawpic (x + 3, y + 119, red_queen_up, 0)
		    drawpic (x + 87, y + 6, red_queen_dn, 0)
		label 13 : % king
		    drawpic (x + 3, y + 119, red_king_up, 0)
		    drawpic (x + 87, y + 6, red_king_dn, 0)
	    end case
	end if

	% To draw the small suit symbols under the numbers or letters
	if suit (card) = 1 then % spade
	    drawpic (x + 4, y + 107, small_spade_up, 0)
	    drawpic (x + 88, y + 23, small_spade_dn, 0)
	elsif suit (card) = 2 then % club
	    drawpic (x + 4, y + 107, small_club_up, 0)
	    drawpic (x + 88, y + 23, small_club_dn, 0)
	elsif suit (card) = 3 then % heart
	    drawpic (x + 4, y + 107, small_heart_up, 0)
	    drawpic (x + 88, y + 23, small_heart_dn, 0)
	elsif suit (card) = 4 then % diamond
	    drawpic (x + 4, y + 107, small_diamond_up, 0)
	    drawpic (x + 88, y + 23, small_diamond_dn, 0)
	end if

	% To draw the large suit symbols in the middle
	if value (card) <= 10 then % non-face card
	    for i : 1 .. value (card)
		case suit (card) of
		    label 1 : % spade
			if z_pos (value (card), i) = 1 then % right-side up
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_spade_up, 0)
			else % up-side down
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_spade_dn, 0)
			end if
		    label 2 : % club
			if z_pos (value (card), i) = 1 then % right-side up
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_club_up, 0)
			else % up-side down
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_club_dn, 0)
			end if
		    label 3 : % heart
			if z_pos (value (card), i) = 1 then % right-side up
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_heart_up, 0)
			else % up-side down
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_heart_dn, 0)
			end if
		    label 4 : % diamond
			if z_pos (value (card), i) = 1 then % right-side up
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_diamond_up, 0)
			else % up-side down
			    drawpic (x + x_pos (value (card), i), y + y_pos
				(value (card), i), big_diamond_dn, 0)
			end if
		end case
	    end for
	end if

	% To draw face card plates
	if value (card) = 11 then % jack
	    case suit (card) of
		label 1 : % spade
		    drawpic (x + 18, y + 20, jack_spade, 0)
		label 2 : % club
		    drawpic (x + 18, y + 20, jack_club, 0)
		label 3 : % heart
		    drawpic (x + 18, y + 20, jack_heart, 0)
		label 4 : % diamond
		    drawpic (x + 18, y + 20, jack_diamond, 0)
	    end case
	elsif value (card) = 12 then % queen
	    case suit (card) of
		label 1 : % spade
		    drawpic (x + 18, y + 20, queen_spade, 0)
		label 2 : % club
		    drawpic (x + 18, y + 20, queen_club, 0)
		label 3 : % heart
		    drawpic (x + 18, y + 20, queen_heart, 0)
		label 4 : % diamond
		    drawpic (x + 18, y + 20, queen_diamond, 0)
	    end case
	elsif value (card) = 13 then % king
	    case suit (card) of
		label 1 : % spade
		    drawpic (x + 18, y + 20, king_spade, 0)
		label 2 : % club
		    drawpic (x + 18, y + 20, king_club, 0)
		label 3 : % heart
		    drawpic (x + 18, y + 20, king_heart, 0)
		label 4 : % diamond
		    drawpic (x + 18, y + 20, king_diamond, 0)
	    end case
	end if
    else % the card back
	drawpic (x + 5, y + 5, back, 0)
    end if
end showcard

% ********** SHUFFLE **********

proc shuffle
    % To shuffle the deck at the start
    var x, where := 0
    var temp : array 1 .. 52 of int
    for a : 1 .. 52
	randint (temp (a), 0, 999)
    end for
    for b : 1 .. 52
	x := 1000
	for c : 1 .. 52
	    if temp (c) < x then
		x := temp (c)
		where := c
	    end if
	end for
	deck (b) := where
	temp (where) := 1000
    end for
    deck (0) := 52 % to set the deck index to 52 cards
end shuffle

% ********** REFRESH **********

proc refresh (player : int)
    % To draw a particular player's hand on the screen, and the discard pile
    var x, x1, x2, y, y1, y2 : int
    if player > 0 then
	case player of % co-ordinates for the blanking rectangle
	    label 1 : % bottom
		x1 := 112
		y1 := 9
		x2 := 527
		y2 := 151
	    label 2 : % right
		x1 := 528
		y1 := 0
		x2 := 630
		y2 := 479
	    label 3 : % top
		x1 := 112
		y1 := 328
		x2 := 527
		y2 := 471
	    label 4 : % left
		x1 := 9
		y1 := 0
		x2 := 111
		y2 := 479
	end case
	mousehide
	drawfillbox (x1, y1, x2, y2, 2) % fill it in green
	if hand (player, 0) > 0 then % they have cards
	    for card : 1 .. hand (player, 0) % each card
		case player of
		    label 1 : % bottom
			x := (640 - (84 + hand (1, 0) * 16)) div 2 + (card -
			    1) * 16
			y := 10
		    label 2 : % right
			x := 529
			y := (480 - (124 + hand (2, 0) * 16)) div 2 + (card
			    - 1) * 16
		    label 3 : % top
			x := ( (640 - (84 + hand (3, 0) * 16)) div 2) + (84
			    + hand (3, 0) * 16) - 100 - (card - 1) * 16
			y := 329
		    label 4 : % left
			x := 10
			y := ( (480 - (124 + hand (4, 0) * 16)) div 2) +
			    (124 + hand (4, 0) * 16) - 140 - (card - 1) * 16
		end case
		if player = 1 then % human
		    showcard (x, y, hand (1, card)) % revealed
		else % computer
		    showcard (x, y, 0) % hidden
		end if
	    end for
	end if
    end if
    if discard (0) > 0 and player = 0 then % there's a card in the discard
	showcard (325, 170, discard (discard (0)))
    end if
    if deck (0) = 0 and present then % the deck's empty
	drawfillbox (214, 169, 316, 311, 2)
	drawbox (214, 169, 316, 311, 0)
	locate (15, 32)
	put "PASS" ..
	present := false
    end if
    if reshuffle_option and not present then % the deck's not there
	showcard (215, 170, 0)
	present := true
    end if
    mouseshow
end refresh

% ********** RESHUFFLE **********

proc reshuffle
    % To reshuffle the discard pile into the deck when it runs out
    var x, where := 0
    var temp1, temp2 : array 1 .. discard (0) - 1 of int
    for a : 1 .. discard (0) - 1
	randint (temp1 (a), 0, 999)
    end for
    for b : 1 .. discard (0) - 1
	x := 1000
	for c : 1 .. discard (0) - 1
	    if temp1 (c) < x then
		x := temp1 (c)
		where := c
	    end if
	end for
	temp2 (b) := where
	temp1 (where) := 1000
    end for
    for slot : 1 .. discard (0) - 1
	deck (temp2 (slot)) := discard (slot)
    end for
    deck (0) := discard (0) - 1 % set the deck counter to the first card
    discard (1) := discard (discard (0)) % put old top card on top
    discard (0) := 1 % set the discard counter to the first card
    locate (15, 30)
    put "RESHUFFLE"
    present := false
    delay (1000)
end reshuffle

% ********** SORT HAND **********

proc sorthand
    % To sort the cards in the human's hand by suit and value
    var f := true
    var temp : int
    % bubble sort
    loop
	exit when not f
	f := false
	for c : 1 .. hand (1, 0) - 1
	    if hand (1, c) > hand (1, c + 1) then
		temp := hand (1, c)
		hand (1, c) := hand (1, c + 1)
		hand (1, c + 1) := temp
		f := true
	    end if
	end for
    end loop
end sorthand

% ********** DRAW **********

proc draw (player, qty : int)
    % To move cards from the top of the deck to a player's hand
    for x : 1 .. qty
	hand (player, hand (player, 0) + 1) := deck (deck (0))
	% write card
	deck (0) := deck (0) - 1 % decrement deck
	hand (player, 0) := hand (player, 0) + 1 % increment hand
    end for
    if deck (0) = 0 and reshuffle_option then % deck is empty
	reshuffle
    end if
    refresh (player) % show new hand
end draw

% ********** DEAL **********

proc deal
    % To place 5 cards into all players' hands and turn over a starter
    discard (0) := 1
    discard (1) := deck (deck (0))
    deck (0) := deck (0) - 1
    for player : 1 .. 4 % anything else would just waste time
	draw (player, 5)
    end for
    for player : 0 .. 4
	refresh (player) % show new hands and starter
    end for
end deal

% ********** SETUP **********

proc setup
    % To cary out miscellaneous setup tasks
    drawfill (320, 240, 2, 2) % table top
    for player : 1 .. 4
	hand (player, 0) := 0 % all hands have zero cards
    end for
    for x : - 3 .. 52 % in case of two's
	discard (x) := 0
    end for
    showcard (215, 170, 0) % deck
    colour (15)
end setup

% ********** PLAY CARD **********

proc playcard (player, card : int)
    % To take a specified card from a hand and put it on the discard pile
    var temp : array 1 .. 52 of int
    if value (hand (player, card)) = 8 then % eights
	play ("6efg")
    elsif value (hand (player, card)) = 11 then % jacks
	play ("6gg4e")
    else
	play ("6e")
    end if
    discard (0) := discard (0) + 1 % increment discard counter
    discard (discard (0)) := hand (player, card) % write card
    hand (player, card) := 0 % erase card
    for a : 1 .. hand (player, 0) % save hand
	temp (a) := hand (player, a)
    end for
    var c := 1
    for a : 1 .. hand (player, 0) % remake hand minus other card
	if temp (a) not= 0 then % it's still there
	    hand (player, c) := temp (a)
	    c := c + 1
	end if
    end for
    hand (player, 0) := c - 1 % decrement hand counter
    refresh (player) % display new hand and discard pile
    refresh (0) % show new discard pile
end playcard

% ********** WIN SCREEN **********

proc winscreen
    % To show the winning screen
    var x, y, c : int
    cls
    drawfill (320, 240, 2, 2) % colour background green
    loop
	% to draw random cards
	randint (x, - 100, 639)
	randint (y, - 140, 479)
	randint (c, 1, 52)
	showcard (x, y, c)
	exit when hasch or buttonmoved ("down")
    end loop
end winscreen

% ********** CHOOSE CARD **********

function choosecard : int
    % To get input from the user (>0=card,-1=draw,-2=quit)
    var chosencard, mx, my, btn, updown : int
    var e : string (1)
    locate (15, 58)
    put "SORT"
    loop % until a choice is made
	chosencard := 0
	if buttonmoved ("down") then % mouse button is hit
	    buttonwait ("down", mx, my, btn, updown)
	    if mx >= (640 - (84 + hand (1, 0) * 16)) div 2 and mx <= ( (640
		    - (84 + hand (1, 0) * 16)) div 2) + hand (1, 0) * 16 and
		    my >= 10 and my <= 150 then % vertical columns
		chosencard := (mx - ( ( (640 - (84 + hand (1, 0) * 16)) div
		    2))) div 16 + 1 % number of card in hand
	    elsif mx > (640 - (84 + hand (1, 0) * 16)) div 2 + hand (1, 0) *
		    16 and mx < (640 - (84 + hand (1, 0) * 16)) div 2 + hand
		    (1, 0) * 16 + 84 and my >= 10 and my <= 150 then % whole
		chosencard := hand (1, 0) % last card
	    elsif mx > 215 and mx < 315 and my > 170 and my < 310 then % pile
		chosencard := - 1 % draw a card
	    elsif mx > 447 and mx < 496 and my > 231 and my < 261 then % sort
		sorthand
		refresh (1)
	    end if
	elsif hasch then % hit a key
	    getch (e)
	    if ord (e) = 27 then % escape
		chosencard := - 2 % quit
	    end if
	end if
	exit when chosencard not= 0 % did something
    end loop
    result chosencard
end choosecard

% ********** LEGAL MOVE **********

function legalmove (player, card : int) : boolean
    % To return the legality of a move (T=legal, F=illegal)
    var legal : boolean := false % return value
    if card > 0 then % not a quit or draw
	if value (hand (player, card)) = value (discard (discard (0))) or
		suit (hand (player, card)) = realsuit then % matches
	    legal := true
	end if
	if value (hand (player, card)) = 8 and crazy_8_option then % eight
	    legal := true
	end if
    elsif card = - 1 and deck (0) = 0 then % pass
	legal := true
    end if
    result legal
end legalmove

% ********** ARTIFICIAL INTELLIGENCE **********

function art_int (player : int) : int
    % To return the computer players' moves
    var flag : boolean := false
    var choice : int
    for card : 1 .. hand (player, 0) % check for possible legal moves
	if legalmove (player, card) then
	    flag := true
	end if
    end for
    if flag then % can play
	loop
	    randint (choice, 1, hand (player, 0)) % pick a card, any card!
	    exit when legalmove (player, choice)
	end loop
    else % draw
	choice := - 1
    end if
    result choice
end art_int

% ********** CHANGE SUIT **********

function changesuit (player : int) : int
    % To allow an eight to change suit
    var st, butnum, x, y := 0
    var spades, clubs, diamonds, hearts, done, ok : int % buttons

    spades := TGUI.Create (TGUI.RADIO)
    TGUI.SetLabel (spades, "Spades")

    clubs := TGUI.Create (TGUI.RADIO)
    TGUI.SetLabel (clubs, "Clubs")
    TGUI.Join (clubs, spades)

    hearts := TGUI.Create (TGUI.RADIO)
    TGUI.SetLabel (hearts, "Hearts")
    TGUI.Join (hearts, clubs)

    diamonds := TGUI.Create (TGUI.RADIO)
    TGUI.SetLabel (diamonds, "Diamonds")
    TGUI.Join (diamonds, hearts)

    ok := TGUI.Create (TGUI.BUTTON)
    TGUI.SetLabel (ok, "OK")
    TGUI.Move (ok, 350, 180)

    if player = 1 then % human
	st := suit (discard (discard (0))) % default suit
    else % computer
	randint (st, 1, 4) % random suit (pretty good AI, eh?)
    end if

    case st of % choose right one
	label 1 :
	    TGUI.Select (spades)
	label 2 :
	    TGUI.Select (clubs)
	label 3 :
	    TGUI.Select (hearts)
	label 4 :
	    TGUI.Select (diamonds)
    end case

    drawfillbox (339, 283, 410, 214, 0) % background

    TGUI.Move (spades, 340, 270)
    TGUI.Show (spades)

    if player = 1 then % human
	TGUI.Show (ok)

	loop % chack for button presses
	    TGUI.ConsiderEvent (butnum, x, y)

	    if butnum > 0 and butnum < 5 then
		st := butnum
	    end if

	    exit when butnum / 5 = butnum div 5 and butnum not= 0 % OK button
	end loop
    end if

    result st % new suit
end changesuit

% ********** DO CARD **********

function docard (player, card : int) : int
    % To return the action to be performed based upon the previous card
    % 0 = nothing, 1 = miss a turn, 2 to 8 = pick up cards
    var action := 0 % return value
    realsuit := suit (discard (discard (0)))
    if value (discard (card)) = 2 and pickup_2_option then % two
	action := 2
	for s : 1 .. 3 % check for previous two's
	    if value (discard (card - s)) = 2 then
		action := action + 2 % add two to the pickup
	    end if
	    exit when value (discard (card - s)) not= 2 % stop adding
	end for
    elsif discard (card) = 12 and pickup_5_option then % queen of spades
	action := 5
    elsif value (discard (card)) = 8 and change_8_option then % eight
	realsuit := changesuit (player)
    elsif value (discard (card)) = 11 and jack_miss_option then % jack
	action := 1
    end if
    result action
end docard

% ********** GAME PLAY **********

proc gameplay
    % The main gameplaying loop
    var e : string (1) := " "
    var player, choice, winner := 0
    var x, y : int
    var action := 0
    cls
    setup
    shuffle
    deal
    randint (player, 1, 4) % choose the starting player
    if player = 1 then % check for action of starter
	action := docard (4, discard (0))
    else
	action := docard (player - 1, discard (0))
    end if
    loop
	refresh (player) % redraw active player's hand
	case player of % location of text
	    label 1 : % bottom
		x := 38
		y := 25
	    label 2 : % right
		x := 72
		y := 15
	    label 3 : % top
		x := 39
		y := 5
	    label 4 : % left
		x := 7
		y := 15
	end case
	if action not= 1 then % turn not skipped
	    if action >= 2 and action <= 8 then % pick up
		for z : 1 .. action
		    delay (1000)
		    draw (player, 1)
		    locate (y, x - 1)
		    put "PICKUP" ..
		    play ("<<<4e>>>")
		end for
		action := 0 % reset action
	    end if
	    loop % until a legal move is chosen
		if player = 1 then % human
		    choice := choosecard
		else % computer
		    delay (1000)
		    choice := art_int (player)
		end if
		if choice = - 1 and deck (0) > 0 then % draw
		    draw (player, 1)
		    locate (y, x)
		    put "DRAW" ..
		    play ("6f")
		end if
		exit when choice = - 2 % hit escape
		exit when legalmove (player, choice) % good move
	    end loop
	    exit when choice = - 2 % hit escape
	    if choice = - 1 then % pass
		locate (y, x)
		put "PASS" ..
	    elsif choice > 0 then % play
		playcard (player, choice)
	    end if
	    if hand (player, 0) = 0 then % empty hand
		winner := player
	    end if
	    action := docard (player, discard (0)) % check action
	else % miss a turn
	    action := 0
	    locate (y, x)
	    put "MISS" ..
	    delay (1000)
	    refresh (player)
	end if
	exit when winner not= 0 % someone won
	player := player + 1 % change player
	if player > 4 then % fix player
	    player := 1
	end if
    end loop
    if winner = 1 then % human won
	winscreen
    elsif winner > 1 then % computer won
	winscreen
    end if
end gameplay

% ********** TITLE SCREEN **********

proc titlescreen
    % To display the title screen
    cls
    var e : string (1)
    var x, c : int
    FileToScreen (0, 0, "images/title.tm2") % cool picture

    loop % random cards
	randint (x, 11, 528)
	randint (c, 1, 52)
	showcard (x, 170, c) % draw 'em
	delay (500)
	drawfillbox (x - 1, 169, x + 101, 311, 2) % erase 'em
	exit when hasch or buttonmoved ("down")
    end loop
end titlescreen

% ********** MAIN LINE **********

randomize
loaddata
loadpics
titlescreen
gameplay

