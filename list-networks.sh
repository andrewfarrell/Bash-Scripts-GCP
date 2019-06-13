#!/bin/bash
#List all Projects
projects=($(gcloud projects list --format="table [no-heading] (NAME)"))
networks=($(gcloud compute networks list --format="table [no-heading] (NAME)"))
k=0
echo 
echo "Project:"
while (($k < ${#projects[@]} ))
    do
        echo
        echo "$k:- ${projects[$k]}"
        echo "Peerings:"
        echo $(gcloud compute networks peerings list)
        j=0
        echo "    Networks:"
        while (($j < ${#networks[@]} ))
            do
                subnets=($(gcloud compute networks subnets list --filter="network:(${networks[$j]})" --format="table [no-heading] (NAME,RANGE)"))
                echo "    ${networks[$j]}"
                echo "    Subnets:"
                i=0
                while (( $i < ${#subnets[@]} ))
                    do 
                        echo "        ${subnets[$i]}"
                        i=$(( i+1 ))
                    done
                    j=$(( j+1 ))
            done
            k=$(( k+1 ))
    done
