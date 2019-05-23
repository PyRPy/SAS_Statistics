* format procedures;
* 9.4 - Permanent Formats;

PROC format;
    value statefmt 14 = 'Ind'
    		   21 = 'Mass'
    		   22 = 'Mich'
    		   23 = 'Minn'
    		   42 = 'Tenn'
    		   49 = 'Wisc'
    		    . = 'Missing'
    		   Other = 'Other';
RUN;