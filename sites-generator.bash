#!/bin/bash

# create the site catalog
cat >sites.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<sitecatalog xmlns="http://pegasus.isi.edu/schema/sitecatalog" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://pegasus.isi.edu/schema/sitecatalog http://pegasus.isi.edu/schema/sc-3.0.xsd" version="3.0">
    <site  handle="local" arch="x86_64" os="LINUX">
        <head-fs>
            <scratch>
                <shared>
                    <file-server protocol="file" url="file://" mount-point="$PWD/scratch"/>
                    <internal-mount-point mount-point="$PWD/scratch"/>
                </shared>
            </scratch>
            <storage>
                <shared>
                    <file-server protocol="file" url="file://" mount-point="$PWD/outputs"/>
                    <internal-mount-point mount-point="$PWD/outputs"/>
                </shared>
            </storage>
        </head-fs>
    </site>
    <site  handle="condorpool" arch="x86_64" os="LINUX">
        <head-fs>
            <scratch />
            <storage />
        </head-fs>
        <profile namespace="pegasus" key="style" >condor</profile>
        <profile namespace="condor" key="universe" >vanilla</profile>
        <profile namespace="condor" key="request_memory " >1000</profile>
        <profile namespace="condor" key="requirements" >(HAS_MODULES =?= TRUE) &amp;&amp; (OpSysMajorVer == 6) &amp;&amp; GLIDEIN_ResourceName =!= "CIT_CMS_T2" &amp;&amp; GLIDEIN_ResourceName =!= "Hyak" </profile>

    </site>
</sitecatalog>
EOF


