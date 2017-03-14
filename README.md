# OSG-KINC

OSG-KINC is a Pegasus workflow that is configured to run on the Open Science Grid.  The workflow uses the Knowledge Independent Network Construction (KINC) software package to build a similarity matrix representing correlation analysis of all pairwise comparisons of genes/transcripts in a Gene Expression Matrix (GEM).  

This repository contains a pre-compiled kinc binary that is executable on the OSG resources requested by this workflow.  The user must provide a properly formatted GEM, and specify the number of jobs that the computation will be split into.  

## Open Science Grid / Execution Environment

The OSG-GEM workflow is designed to execute on the [Open Science Grid](https://www.opensciencegrid.org/) via the
[OSG Connect](https://osgconnect.net/) infrastructure. Access to the system can be requested on the 
[sign up page](https://osgconnect.net/signup). 

Once you have an account and have joined a project, login to the login02 submit node.
This node can be accessed by ssh:

        ssh username@login02.osgconnect.net

A workflow specific ssh key has to be created. This key is used for some of the data staging steps of the workflow. 

        $ mkdir -p ~/.ssh
        $ ssh-keygen -t rsa -b 2048 -f ~/.ssh/workflow
          (just hit enter when asked for a passphrase)
          
        $ cat ~/.ssh/workflow.pub >>~/.ssh/authorized_keys

Test that the key is set up correctly by sshing from login02 to login02, using the new key:

        $ ssh -i ~/.ssh/workflow login02.osgconnect.net

If that works, log out from the new session. You are now ready to submit workflows.

## Input GEM Format

The workflow will automatically identify the dimensions of the input Gene Expression Matrix.  However, this matrix must be formatted as follows:

- Tab delimited text file
- No 'GeneID' string in header.  First value of header is a sample ID
- Number of columns = Number of datasets (can count number of columns in header to get this value)
- Number of Rows = Number of rows in file including the header

Dataset1	Dataset2	Dataset3
Gene1	1	0	2
Gene2	0	3	5
Gene3	2	2	4
Gene4	11	12	0
Gene5	15	0	3

For this dataset, the kinc parameters would be identified as follows:

rows: 6

columns: 3 

Once the input GEM is formatted properly, it must be named with the '.txt' file extension and placed in the 'task-files' directory of the workflow.  

In addition, a compressed tar archive with the extension 'tar.gz' of this text file must be provided.  This can be generated using the following command, using 'test.txt' as an example:

    $ tar czf test.tar.gz test.txt
    
    
    

        
