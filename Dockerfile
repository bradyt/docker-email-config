FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
        ca-certificates \
        emacs-nox \
        isync \
        msmtp \
        mu4e \
        mutt \
        neomutt \
        notmuch \
        vim

WORKDIR /root/

ADD .mbsyncrc.org /root/.mbsyncrc.org
RUN emacs -batch ~/.mbsyncrc.org -f org-babel-tangle

RUN mkdir /root/Maildir

ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV TERM xterm-256color

ADD password_imap /root/password_imap
ADD password_smtp /root/password_smtp

RUN mkdir /root/Maildir/Sent
RUN mkdir /root/Maildir/Drafts
RUN mkdir /root/Maildir/Trash

RUN mbsync --verbose --all
RUN mbsync --verbose --all
RUN mbsync --verbose --all
# CMD mbsync --verbose --all --list

RUN mu index

ADD mail-config.org /root/mail-config.org
RUN emacs -batch ~/mail-config.org -f org-babel-tangle

# RUN notmuch new

# RUN printf "Subject: Test\nhello there username." | msmtp username@fastmail.com

# CMD emacs -f mu4e

# CMD emacs -f notmuch

# CMD mutt
