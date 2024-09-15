---
title: "Linux - Communicating through the Terminal to Other Users"
layout: post
---

In this tutorial, we’ll learn how to leave a message to another local user in Linux. There are several commands that we can use to achieve this. We’ll first look at the wall command. We’ll then cover the remaining commands mostly used for this purpose.

## The wall Command

The wall (write all) command writes messages to all the local user accounts currently logged in. Hence, it’s widely used by system administrators. Let’s look at this command’s format:

```bash
$ wall [OPTION] [message | file]
```

Now, let’s see some examples.

### Broadcasting a Message to All Users

For instance, to send a message to all local users, we’d execute the wall command with the message text:

```bash
$ wall The system will shut down at 08:45 PM
Broadcast message from sidrah@ubuntu (pts/0) (Sat Jan 7 07:14:50 2023): 
The system will shut down at 08:45 PM
```

Other local users would get the message once they open the terminal. In case we don’t specify the message with the wall command, the message will be read from stdin.

Also, in some Linux versions, the command requires superuser access. For instance, to send the message from stdin with superuser access, we only run the wall command:

```bash
$ sudo wall
```

After typing out our message and pressing `Ctrl + D`, we send it as a superuser.

### Broadcasting a File to All Users

Alternatively, we can also send a message in a file using the wall command. For this, we’ll first create the file with an editor like vi:

```bash
$ vi message.txt
```

Next, let’s add the message inside the file that we’d like to send to other local users:

```text
The system will shut down at 08:45 PM
```

After that, we can exit the text editor.

Lastly, we’ll use the wall command followed by the file name:

```bash
$ sudo wall message.txt
```

The command above sends whatever message we wrote inside the file message.txt to all active users on the system.

## The write Command
The wall command sends a message to all the logged-in users. If we want to leave a message to a particular user, the write command is more suitable for this task. In addition, the command is installed by default on Linux machines.

For instance, if the user `sidrah` wants to send a message to a user `mary`, they’d execute the write command with the username `mary`:

```bash
$ write mary
Hey, mary!
Did you complete the assignment? 
^D
```

Here, `^D` means `Ctrl + D`. We press the combination to stop writing the message.

This initiates a chat session between the users and delivers the first messages to the user `mary`. Whatever user `sidrah` writes now appears in mary‘s terminal.

If user `mary` wishes to respond, they’d respond back by using the write command followed by a username:

```bash
$ write sidrah
```

Then, mary also types what they want to send to user `sidrah` in the terminal. To terminate the session, both users can press `Ctrl + C`.

Since the write command only delivers messages to the users currently logged in, user `sidrah` may want to check which user is currently logged in. For this, they can use the who command:

```bash
$ who
sidrah   tty2    2023-01-07 09:07 (tty2)
mary tty3     2023-01-07 10:42 (tty3)
```

The output displays the currently logged-in users.

By default, the message option is enabled on Linux machines. To stop receiving unwanted messages from any local user, we’d use the mesg command with the n option:

```bash
$ mesg n
```

This blocks all incoming messages. To enable messaging again, we can use the y option:

```bash
$ mesg y
```

The y argument to mesg allows the current user to receive messages from other users.

## The `talk` Command

If we want to interact with multiple local users in Linux, we can use the talk command.

By default, the talk command isn’t installed in Linux. To install it in **Ubuntu** or **Debian**, we’ll use the `apt` package manager:

```bash
$ sudo apt-get install talk
$ sudo apt-get install talkd
```

For **CentOS** or **Fedora**, we can use the `yum` package manager:

```bash
$ sudo yum install talk
$ sudo yum install talk-server
```

The talk command opens a new double-pane window for communication. The participants type messages in the top portion of the display and view the received messages at the bottom section.

Also, to respond to an incoming message, we can use the talk command followed by the username. Let’s look at an example.

For instance, if we want to talk to user mary on the Ubuntu system, the command would look like this:

```bash
$ talk mary@ubuntu
Message from sidrah@ubuntu
talk: connection requested by mary@ubuntu
talk: respond with: talk mary@ubuntu
```

To this, the user mary would respond using the talk command along with the username:

```bash
$ talk sidrah@ubuntu
```

Let’s look at the exchange of messages:

```bash
----------------------------= YTalk version 3.3.0 =--------------------------
Are you ready for the meeting?
-------------------------------= mary@ubuntu =---------------------------- 
Yes, I'm ready!
```

On the other hand, the window panes will be reversed on the other user’s screen:

```bash
----------------------------= YTalk version 3.3.0 =--------------------------
Are you ready for the meeting?
-------------------------------= mary@ubuntu =----------------------------
Yes, I'm ready!
```

To terminate the chat window, the user presses `Ctrl + C`. This stops the chat session.

## Conclusion

In this article, we discussed how users can use the wall command to leave a message. After that, we looked at the write command to send messages to a local user. Finally, we saw how to send a message using talk.

We learned that while `wall`, `write`, and `talk` are the basic commands we can utilize to leave a message for another user in Linux, each has a special feature set.
