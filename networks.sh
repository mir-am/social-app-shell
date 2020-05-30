#!/bin/bash

# This is a social network app that is developed for edX Unix course 
# Author: Amir Mir (s.a.m.mir@tudelft.nl)
# Date: May, 2020
# License: GNU General Public License v3.0

function create_social_network() {
    # Creates required folders and files for a new social network.
    # $1: The name of a social network.

        mkdir -p "./networks/$1";
        mkdir -p "./networks/$1/posts";
        touch "./networks/$1/members";
        printf "Created the network %s at %s\n" "$1" "./networks/$1";
}

function join_social_network() {
    # Lets the user join a given social network if exists.
    # $1: The name of a social network

    if is_joined_network "$1"; then
        printf "You've already joined the network %s\n" "$1";
    else
        printf "%s\n" "$(whoami)" >> "./networks/$1/members";
        printf "%s\n" "$1" >> "./users/$(whoami)/networks"; 
        printf "You've now joined the social network %s.\n" "$1";
    fi
}

function leave_social_network() {
    # Lets the user leave a social network
    # $1: The name of a social network

    if is_joined_network "$1"; then
        rm_line_from_file "$(whoami)" "networks/$1/members";
        rm_line_from_file "$1" "users/$(whoami)/networks";
        printf "You left the network %s\n" "$1";
    else
        printf "You have not joined the network %s\n" "$1";
    fi
}

function show_network_members() {
    # Prints the list of members from the networks that the user joined.

    while read -r n; do
        printf "The members of the network %s:\n" "$n";
        while read -r m; do
            printf "%s\n" "$m";
        done < networks/"$n"/members
    done < users/"$(whoami)"/networks
}

function check_network_exists() {
    # Checks whether a social network exists in the system or not.
    # $1: The name of a network

    if [[ -d "networks/$1" ]]; then
        return 0;
    else
        printf "The network %s doesn't exist!\n" "$1"
        return 1;
    fi
}

function show_existing_networks() {
    # Prints a list of existing networks in the system.

    printf "List of existing networks:\n";
    for n in ./networks/*/; do
        printf "%s\n" "$(basename "$n")";
    done
}


function is_joined_network() {
    # Checks whether a user joined to a network or not.
    # $1: The name of a network

    if grep -q "$(whoami)" "./networks/$1/members" && grep -q "$1" "./users/$(whoami)/networks"; then
        return 0;
    else
        printf "You have not joined the social network %s yet!\n" "$1";
        return 1;
    fi
}