Input file format:

Tab delimited ematrix
Number of columns = Number of datasets (can count number of columns in header to get this value)
Number of Rows = Number of rows in file including the header

Example Dataset:

Dataset1	Dataset2	Dataset3
Gene1	1	0	2
Gene2	0	3	5
Gene3	2	2	4
Gene4	11	12	0
Gene5	15	0	3

For this dataset, the kinc parameters would be as follows:

rows: 6
columns: 3 
-----------------

Relevant Files and Directories:

-----------------------

kinc (software executable)
kinc_job_with3args.bash (executable shell script)
ematrix.tar.gz (input file)
-----------------------

submit.bash (Script that launches the workflow)
dax-generator-kinc.py (generates dax.xml.)
sites-generator.bash (generates sites.xml. The path of output and scratch direct
ories are defined here)
pegasusrc   (config file for pegasus.  Same file for every workflow)
------------------------

scratch/    (input and output files are temporarily stored here)
workflows/  (job files are stored here)
outputs/    (Output is transferred here once workflow completes)
------------------------

How to submit the workflow for a new input file called "mynew_matrix.txt" which
is compressed as "mynew_matrix.tar.gz"

1) In "kinc_job_with3args.bash" file, change "--rows 10000 --cols 200 " to approp
riate values.

2) In "dax-generator-kinc.py" file, rename the variable
        (a) ematrix_input_targz_filename = "test.ematrix.tar.gz" --> "mynew_matr
ix.tar.gz"
        (b) ematrix_input_filename = "test.ematrix" --> "mynew_matrix.txt"

3) If your "--num_jobs 100000" then, in "dax-generator-kinc.py" file change
the loop
         (a) for i in range (1,100): --> for i in range (1,10001):
