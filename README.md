This repo records some configs to get started at trying any of four
email clients, mutt, mu4e, gnus and notmuch.el, all pointed at the
same Maildir. The Maildir is pulled via isync/mbsync.

The configuration leans more towards mu4e, as that is what I usually
end up using, but the other clients are somewhat setup, partly for the
sake of wanting to try them out, and similarly for the sake of
checking if all four can be setup for the same Maildir.

If you have subfolders in your account, for example `INBOX/Todo`, that
may cause some navigation issues in mutt or Gnus, you could choose to
use `Flatten .` rather than `Subfolders Verbatim`, but I chose to
simply remove all instances of subfolders in my email account for now.

This is really just for testing a configuration. The workflow is to
call `make` to test the setup in Docker. Then you can easily iterate
on various options, and troubleshooting issues. The intention is that
you would then use it to setup your own configuration with these
settings in mind.
