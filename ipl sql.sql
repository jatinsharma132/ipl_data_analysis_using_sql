create database ipl;

use ipl;

select * from  `players`;

-- q1. Retrieve the names and teams of all players who are "Batting Allrounders".

select name , team , playingRole from players 
where playingRole = "Batting Allrounder";

-- q2.List all batsmen from "Super Kings" who scored more than 50 runs in a match.

select teamInnings,batsmanName,runs from batting
where teamInnings = "Super Kings" and runs >50;


-- q3.Calculate the total number of runs scored by "FafduPlessis" across all matches.

select batsmanName ,  sum(runs) as total_runs  from batting 
where batsmanName = "FafduPlessis";


-- q4.Find the average Strike Rate (SR) of all players in the "fact_batting_summary" table.-- 

select batsmanName , round(avg(SR),2) as avg_SR from batting
group by batsmanName;

-- q5.Group the total number of 4s and 6s hit by each team across all matches.

select teamInnings , sum(4s), sum(6s) from batting 
group by teamInnings;

-- q6.Find out which player has the highest total runs across all matches.

select batsmanName , sum(runs) as highest_runs from batting
group by batsmanName limit 1;

-- q7.List all players who have played for "Super Kings" along with their batting style.

select name , team , battingStyle from players 
where team = "super kings";

-- q8.Combine the player and match tables to find the top three
--  players with the highest individual scores in the "Super Kings Vs KKR" match.

select matches , BatsmanName , runs from batting
where matches = "Super Kings Vs KKR" 
order by runs desc
limit 3;

-- q9.For each match, list the winning team along with the highest run scorer from the losing team.

SELECT 
    `match`.match_id, 
    `match`.winner, 
    batting.batsmanName, 
    MAX(batting.runs) AS highest_runs
FROM
    `match`
JOIN
    batting ON `match`.match_id = batting.match_id
WHERE 
    batting.matches != `match`.winner
GROUP BY 
    `match`.match_id, 
    `match`.winner, 
    batting.batsmanName;
    
-- q.10 Identify which player from "KKR" has the highest Strike Rate in matches against "Super Kings".

select matches , batsmanName ,max(SR) as highest_SR from batting
where matches = "KKR Vs Super Kings" and teamInnings = "KKR"
group by batsmanName 
limit 1;
    
    
-- q11.Find the player with the highest Strike Rate in a match where "Super Kings" won.

select batting.BatsmanName , max(batting.SR) , `match`.winner 
from batting join `match` on batting.match_id = `match`.match_id 
where `match`.winner = "Super Kings"
group by batting.BatsmanName , `match`.winner 
limit 1;

-- q12.List the players who have scored more than the average runs scored in a match.

select BatsmanName , runs from batting
where runs >(select avg(runs) from batting)
group by BatsmanName ,runs;

-- q13.Find all players who have a batting position lower than 3 but have scored more than 30 runs in a match.

select BatsmanName , battingPos, runs from batting 
where battingPos>3;

-- q14.Retrieve the names of all players who have
--  been not out (not dismissed) in a match and have a Strike Rate above 150.

select BatsmanName , `out/not_out` , SR from batting 
where SR > 150 and `out/not_out` = "not_out";

-- q15.Calculate the number of matches 
--  where the winning margin was greater than 20 runs


select count(winner) as total_matches  , margin
from `match` where margin > 20 
group by margin;
