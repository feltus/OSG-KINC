#!/usr/bin/env python

from Pegasus.DAX3 import *
import sys
import os

# Create a abstract dag
dax = ADAG("kinc-pegasus-jobs")

base_dir = os.getcwd()

# Add executables to the DAX-level replica catalog
kinc_wrapper = Executable(name="kinc_job_with3args.bash", arch="x86_64", installed=False)
kinc_wrapper.addPFN(PFN("file://" + base_dir + "/" + "kinc_job_with3args.bash ", "local"))
kinc_wrapper.addProfile(Profile(Namespace.PEGASUS, "clusters.size", 1))
dax.addExecutable(kinc_wrapper)

# Add ematrix file to the DAX-level replica catalog
ematrix_input_targz_filename = "ematrix-log-no.tar.gz"
ematrix_input_targz_file = File(ematrix_input_targz_filename)
ematrix_input_targz_file.addPFN(PFN("file://" + base_dir + "/" + ematrix_input_targz_filename, "local"))
dax.addFile(ematrix_input_targz_file)

# Add kinc file to the DAX-level replica catalog
kinc_filename = "kinc"
kinc_file = File(kinc_filename)
kinc_file.addPFN(PFN("file://" + base_dir + "/" + kinc_filename, "local"))
dax.addFile(kinc_file)

ematrix_input_filename = "ematrix-log-no.txt"

# add jobs for job index
for i in range (1, 10001):
     kinc_job = Job(name="kinc_job_with3args.bash")
     kinc_job.addArguments(ematrix_input_targz_filename, ematrix_input_filename, str(i))
     kinc_job.uses(ematrix_input_targz_filename, link=Link.INPUT)
     kinc_job.uses(kinc_filename, link=Link.INPUT)

     sc_filename = "clusters-sc" + str(i) + ".tar.gz"
     sc_file = File(sc_filename)
     sc_file.addPFN(PFN("file://" + base_dir + "/" + sc_filename, "local"))
     #dax.addFile(sc_file)

     kinc_out_filename = "kinc.out."+ str(i)
     kinc_out_file = File(kinc_out_filename)
     kinc_out_file.addPFN(PFN("file://" + base_dir + "/" + kinc_out_filename, "local"))
     #dax.addFile(kinc_out_file)

     kinc_job.uses(kinc_out_filename, link=Link.OUTPUT)
     kinc_job.uses(sc_filename, link=Link.OUTPUT)

     dax.addJob(kinc_job)

# Write the DAX to stdout
f = open("dax.xml", "w")
dax.writeXML(f)
f.close()

