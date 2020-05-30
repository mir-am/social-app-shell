#!/bin/bash

# This is a social network app that is developed for edX Unix course 
# Author: Amir Mir (s.a.m.mir@tudelft.nl)
# Date: May, 2020
# License: GNU General Public License v3.0

function post_new_story() {
    # Lets the user publish a post in a specified network.

    read -rp "Enter the name of the network: " network_name;
    if can_user_post "$network_name"; then
        read -rp "Enter title of your post: " post_title;
        printf "Writer your post below and hit ctrl-d when done: \n";
        post_content=$(cat)

        # Here, the post title should be converted to a valid file name.
        post_file_title=$(convert_post_title "$post_title");
        printf "Network: %s\nTitle: %s\nAuthor: %s\nDate: %s\n-----------------------\n%s" "$network_name" "$post_title" "$(whoami)" "$(date)" "$post_content" > "networks/$network_name/posts/$post_file_title";
        printf "Your post was succesfully written to %s\n" "networks/$network_name/posts/$post_file_title";
    fi
}

function find_existing_posts() {
    # Extracts a list of posts from the networks that the user joined.

    # Posts are a global variable across the whole script.
    posts=()
    while read -r n; do
        for p in networks/"$n"/posts/*; do
           #posts+=("$(< "$p" grep 'Title: ' | cut -d ":" -f 2;)");
           posts+=("$p") 
        done
    done < users/"$(whoami)"/networks
}

function show_existing_posts() {
    # Prints posts from the networks that the user joined.

    printf "List of existing posts:\n";
    for p in "${posts[@]}"; do
        printf "%s\n" "$(show_post_title "$p")";
    done
}

function show_post() {
    # Shows a particular post for a user.
    # $1: The name of a post
    # $2: Prints the specified post on screen if exists

    for p in "${posts[@]}"; do
        if [[ $1 == "$(show_post_title "$p")" ]]; then
            if [[ $2 -eq 1 ]]; then
                cat "$p";
            fi
            return 0;
        fi
    done
    printf "The post %s doesn't exist on the system.\nMake sure that you joined a network and use pull option.\n" "$1"
    return 1;
}

function convert_post_title() {
    # Converts the title of a post to a valid name that can be saved on the disk
    # $1: The title of a post
    
    # shellcheck disable=SC2005
    echo "$(echo "$1" | tr " " "_" | tr '[:upper:]' '[:lower:]')";
}

function show_post_title() {
    # Shows a post title after trimming trailing and leading space
    # $1: The path of a post

    # shellcheck disable=SC2005
    echo "$(< "$1" grep 'Title: ' | cut -d ":" -f 2 | awk '{$1=$1;print}')";
}

function like_post() {
    # Adds a post to a user's liked posts.
    # $1: The name of a post

    if show_post "$1" "0"; then
        if ! grep -q "$1" "./users/$(whoami)/liked_posts"; then
            printf "%s\n" "$1" >> "./users/$(whoami)/liked_posts";
            printf "You've liked the post %s\n" "$1";
        else
            printf "You've already liked the post %s\n" "$1";
        fi
    fi
}