FROM debian:latest

RUN apt-get update && apt-get install -y \
        ca-certificates \
        emacs-nox \
        isync \
        msmtp \
        mu4e \
        mutt \
        neomutt \
        notmuch \
        offlineimap \
        vim

ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV TERM xterm-256color

WORKDIR /root/

ADD .mbsyncrc.org /root/.mbsyncrc.org
RUN emacs -batch ~/.mbsyncrc.org -f org-babel-tangle

# ADD .offlineimaprc.org /root/.offlineimaprc.org
# RUN emacs -batch ~/.offlineimaprc.org -f org-babel-tangle

ADD password_imap /root/password_imap

RUN mkdir /root/Maildir

RUN mbsync --verbose --all
RUN mbsync --verbose --all # year: 2020
RUN mbsync --verbose --all # month: 11
RUN mbsync --verbose --all # day: 1
RUN mbsync --verbose --all # hour: 0
RUN mbsync --verbose --all # minute: 0

RUN mu init
RUN mu index

ADD mail-config.org /root/mail-config.org
RUN emacs -batch ~/mail-config.org -f org-babel-tangle

# CMD emacs -f mu4e

# RUN mkdir /root/Maildir/Archive

# RUN mkdir /root/Maildir

# ADD password_imap /root/password_imap
# ADD password_smtp /root/password_smtp

# RUN mkdir /root/Maildir/Sent
# RUN mkdir /root/Maildir/Drafts
# RUN mkdir /root/Maildir/Trash

# RUN mbsync --verbose --all
# CMD mbsync --verbose --all --list


# RUN notmuch new

# RUN printf "Subject: Test\nhello there username." | msmtp username@fastmail.com

# CMD emacs -f mu4e

# CMD emacs -f notmuch

# CMD mutt
