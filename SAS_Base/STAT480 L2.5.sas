DATA temp;
  input subj 1-4 name $ 6-23 gender 25 height 27-28 weight 30-32;
  datalines;
1024 Alice Smith        1 65 125
1167 Maryann White      1 68 140
1168 Thomas Jones       2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia Ho         1 63 115
  ;
RUN;


PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;


DATA temp;
  input init $ 6 f_name $ 6-16 l_name $ 18-23
        weight 30-32 height 27-28;
  datalines;
1024 Alice       Smith  1 65 125
1167 Maryann     White  1 68 140
1168 Thomas      Jones  2    190
1201 Benedictine Arnold 2 68 190
1302 Felicia     Ho     1 63 115
  ;
RUN;


PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;
