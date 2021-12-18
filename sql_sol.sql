-- 1. Write a SQL query to find the date EURO Cup 2016 started on.
SELECT min(play_date)
FROM euro_cup_2016.match_mast
;

--2. Write a SQL query to find the number of matches that were won by penalty shootout.
SELECT count(distinct match_no)
FROM euro_cup_2016.match_details
Where decided_by = 'P'
;


--3. Write a SQL query to find the match number, date, and score for matches in which no stoppage time was added in the 1st half.
SELECT distinct a.match_no, a.play_date, a.goal_score
FROM euro_cup_2016.match_mast a
join euro_cup_2016.goal_details b
on a.match_no = b.match_no
where b.goal_half = 1
and b.goal_schedule <> 'ST'
;

--4. Write a SQL query to compute a list showing the number of substitutions that happened in various stages of play for the entire tournament.

--5. Write a SQL query to find the number of bookings that happened in stoppage time.
SELECT sum(booking_time)
FROM euro_cup_2016.player_booked
where play_schedule = 'ST';


--6. Write a SQL query to find the number of matches that were won by a single point, but do not include matches decided by penalty shootout.
SELECT count(distinct b.match_no)
FROM euro_cup_2016.soccer_team a
join euro_cup_2016.match_details b 
on a.team_id = b.team_id
where decided_by <> 'P'
;

--7. Write a SQL query to find all the venues where matches with penalty shootouts were played.
SELECT count(distinct match_no)
FROM euro_cup_2016.soccer_team a
join euro_cup_2016.match_details b 
on a.team_id = b.team_id
where decided_by <> 'P' and points = 1
;

--8. Write a SQL query to find the match number for the game with the highest number of penalty shots, and which countries played that match.
SELECT  a.match_no, b.country_name, a.kick_no
FROM euro_cup_2016.penalty_shootout a
join euro_cup_2016.soccer_country b
on a.team_id = b.country_id
order by kick_no desc
limit 1
;



--9. Write a SQL query to find the goalkeeper’s name and jersey number, playing for Germany, who played in Germany’s group stage matches.
SELECT distinct a.player_name, a.jersey_no
FROM euro_cup_2016.player_mast a
join euro_cup_2016.soccer_country b on a.team_id = b.country_id
join euro_cup_2016.match_details c on c.team_id = a.team_id
where b.country_name = 'Germany'
and posi_to_play = 'GK' 
and play_stage = 'G'
;

--10. Write a SQL query to find all available information about the players under contract to Liverpool F.C. playing for England in EURO Cup 2016.
SELECT distinct  a.*
				, b.match_no 
				, b.booking_time
                , b.sent_off
                , b.play_schedule
                , b.play_half
				, c.in_out
                , c.time_in_out
                , c.play_schedule
                , c.play_half
                , mc.player_captain
                ,ps.score_goal
                , ps.kick_no
FROM euro_cup_2016.player_mast a                                                
left join euro_cup_2016.player_booked b on a.player_id = b.player_id 
left join euro_cup_2016.player_in_out c on b.player_id = c.player_id  and c.match_no = b.match_no
left join euro_cup_2016.match_captain mc on mc.player_captain = a.player_id and mc.match_no = b.match_no
left join euro_cup_2016.penalty_shootout ps on ps.player_id = a.player_id and ps.match_no = b.match_no
where playing_club like '%Liverpool%'
;



--11. Write a SQL query to find the players, their jersey number, and playing club who were the goalkeepers for England in EURO Cup 2016.
select player_name, jersey_no, playing_club
from  euro_cup_2016.player_mast pm
join euro_cup_2016.soccer_country sc on pm.team_id = sc.country_id
where posi_to_play = 'GK'
and sc.country_name = 'England'
;


--12. Write a SQL query that returns the total number of goals scored by each position on each country’s team. Do not include positions which scored no goals.
select  sc.country_name, sum(goal_agnst) as total_goals
from euro_cup_2016.player_mast pm
left join euro_cup_2016.soccer_team gd on gd.team_id = pm.team_id
left join euro_cup_2016.soccer_country sc on sc.country_id = gd.team_id
group by 1
having total_goals > 0
;

--13. Write a SQL query to find all the defenders who scored a goal for their teams.
select distinct player_name, posi_to_play
from  euro_cup_2016.goal_details gd
join euro_cup_2016.player_mast pm on pm.player_id = gd.player_id
where pm.posi_to_play= 'FD'
;


--14. Write a SQL query to find referees and the number of bookings they made for the entire tournament. Sort your answer by the number of bookings in descending order.
select referee_name, count(distinct match_no) as total_bookings
from euro_cup_2016.referee_mast a
left join euro_cup_2016.match_mast b on a.referee_id = b.referee_id
group by 1
order by 2 desc
;

--15. Write a SQL query to find the referees who booked the most number of players.
select referee_name, count(distinct c.player_id) as total_players_booked
from euro_cup_2016.referee_mast a
left join euro_cup_2016.match_mast b on a.referee_id = b.referee_id
left join euro_cup_2016.player_booked c on c.match_no = b.match_no
group by 1
order by 2 desc
limit 1
;

--16. Write a SQL query to find referees and the number of matches they worked in each venue.
select referee_name, venue_name, count(distinct a.match_no) as number_of_matched
from euro_cup_2016.match_mast a
left join euro_cup_2016.referee_mast b on a.referee_id = b.referee_id
left join euro_cup_2016.soccer_venue c on c.venue_id = a.venue_id
group by 1,2
;


--17. Write a SQL query to find the country where the most assistant referees come from, and the count of the assistant referees.
select  b.country_name, count(distinct a.ass_ref_id) as ct_assistant_referres
from euro_cup_2016.asst_referee_mast a
left join euro_cup_2016.soccer_country b on a.country_id = b.country_id
group by 1
order by 2 desc
limit 1
;

--18. Write a SQL query to find the highest number of foul cards given in one match.


--19. Write a SQL query to find the number of captains who were also goalkeepers.
select count(distinct player_id) as total_count
from euro_cup_2016.player_mast a
join euro_cup_2016.match_captain b on b.player_captain = a.player_id
where a.posi_to_play = 'GK' 
;

--20. Write a SQL query to find the substitute players who came into the field in the first half of play, within a normal play schedule.
select *
from euro_cup_2016.player_in_out a
where a.play_schedule = 'NT'  and a.play_half = 1 #and a.in_out = 'I'
;