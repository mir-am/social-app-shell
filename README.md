# SN - A command-line based social network program for Unix systems
This is a social network program that is developed for edX Unix course. The program is implemented based on the given specification by the course.

Content:
- [Requirements ](#requirements)
- [Quick install](#quick-install)
- [Usage](#usage)
- [Specifications](#Specifications)
- [License](#license)

# Requirements 
In order to install and run the program, the following requirements should be met:

- The organization should create one Git repository to host the program and its data.
- All the users of the program should preferably have a Linux-based system.
- Each user is registered in the program based on his/her username in the system. Therefore, it is assumed that all the users work on the same server.
- All the users of the program must have a Git account that has access to the Git repository that hosts the program and its data.

# Quick install
1- Clone the project into a folder of your interest:
```
git clone https://github.com/mir-am/social-app-shell.git && cd social-app-shell
```
2- Run the program using the following command:
```
sh sn help
```

# Usage
```
$ sh sn help
sn - A command-line based social network program for Unix systems (v0.1)
Copyright (c) 2020, Amir M. Mir

Options:
create <name>     Create a new social network in the system.
join <name>       Join an existing social network in the system.
leave <name>      Leave an existing social network.
pull              Pull new social networks and posts.
log               Show a list of existing posts.
show <name>       Show a specified post.
post              Publish a new post.
like <name>       Like a specified post.
push              Push locally made changes back to the server.
members           Show the members of subscribed networks.
networks          Show a list of existing social networks in the system.
follow <name>     Follow a specified user.
unfollow <name>   Unfollow a specified user.
help              Show the description of program's options.
```

# Specifications
The `sn` program is designed and implemeneted based on the following specifications:
- The `networks` folder contains data for existing social networks. For instance:
```
-networks
--food_network
---posts
----pizza
---members
```
- The `users` folder contains data for the users of the social network program. For instance:
```
-users
--amir
---networks
---following
---liked_posts
```

- The `posts` folder contains posts for the social network.
- The `members` file contains a list of users that are subscribed to the social network.
- The `networks` file contains a list of social networks that a user is subscribed to.
- The `following` file contains a list of users that a user is following.
- Each post has the following format:
```
Network: The name of a social network
Title: Name of a post
Author: Name of the post's author
Date: The date at which the post is published (e.g. Thu May 28 18:07:59 CEST 2020)
-----------------------
Content of the post
```

# License
GNU General Public License v3.0. Check out the `LICENSE` file for more info.
