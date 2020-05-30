#!/bin/bash

# This is a social network app that is developed for edX Unix course 
# Author: Amir Mir (s.a.m.mir@tudelft.nl)
# Date: May, 2020
# License: GNU General Public License v3.0

function create_user() {
    # Creates required files for a new user based on his/her system username.

    mkdir -p "./users/$(whoami)"
    # A file to track networks that a user joined
    touch "./users/$(whoami)/networks"
    # A file to track people whom a user follows
    touch "./users/$(whoami)/following"
    # A file to track posts that a user likes
    touch "./users/$(whoami)/liked_posts"
    printf "The user %s is created on the system. Welcome!\n" "$(whoami)"
}

function can_user_post() {
    # Checks whether the user can post on a soical network or not.

    if check_network_exists "$1"; then
        if is_joined_network "$1"; then
            return 0;
        fi
    fi
    return 1;
}

function check_user_exists() {
    # Checks whether the user already exists in the system.

    if [[ -d "./users/$(whoami)" ]]; then
        #printf "Welcome %s!\n************************\n" "$(whoami)"
        return 0;
    else
        return 1;
    fi
}

function follow_user() {
    # Adds another user to a user's following users.
    # $1: The name of a user

    if [[ -d "./users/$1" ]]; then
        printf "%s\n" "$1" >> "./users/$(whoami)/following";
        printf "You're now following the user %s.\n" "$1";
    else
        printf "The user %s doesn't exist in the system.\n" "$1";
    fi
}

function unfollow_user() {
    # Removes a user from a user's following users.
    # $1: The name of a user

    if [[ -d "./users/$1" ]]; then
        rm_line_from_file "$1" "./users/$(whoami)/following";
        printf "You've now unfollowed the user %s.\n" "$1";
    else
        printf "The user %s doesn't exist in the system.\n" "$1";
    fi
}
