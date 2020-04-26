require "encoded-character";
if header :contains "Subject" "$${hex:24 24}" {
	discard;
}


"$${hex:40}"         # -> "$@"
"${hex: 40 }"        # -> "@"
"${HEX: 40}"         # -> "@"
"${hex:40"           # -> "${hex:40"
"${hex:400}"         # -> "${hex:400}"
"${hex:4${hex:30}}"  # -> "${hex:40}"
"${unicode:40}"      # -> "@"
"${ unicode:40}"     # -> "${ unicode:40}"
"${UNICODE:40}"      # -> "@"
"aaaaaa${UnICoDE:0000040}" # -> "@"
"${Unicode:40}"      # -> "@"
"${Unicode:Cool}"    # -> "${Unicode:Cool}"
"${unicode:200000}"  # -> error
"${Unicode:DF01}     # -> error
"

# This script was copied from https://wiki2.dovecot.org/Pigeonhole/Sieve/Examples
# on 2020-04-08.
require ["fileinto", "envel\\ope"];
if not address :is "to" "dovecot@dovecot.org" {
	fileinto "Dovecot-list";
} elsif envelope :is "from" "owner-cipe-l@inka.de" {
	fileinto "lists.cipe";
}
elsif anyof (header :contains "X-listname" "lugog@cip.rz.fh-offenburg.de",
header :contains "List-Id" "Linux User Group Offenburg") {
	fileinto "ml.lugog";
} else {
	# The rest goes into INBOX
	# default is "implicit keep", we do it explicitly here
	keep;
}


if header :contains :comparator "i;octet" "Subject" "MAKE MONEY FAST" {
	reply "PISS OFF";
}



if header :contains "From" "$${hex:AB EF 45}" {
	please 20K
	stop this;
	stop;
}


require ["fileinto", "reject"];

# Daffy Duck is a good friend of mine.
if address :is "from" "daffy.duck@example.com"
{
	fileinto "friends";
}

# Reject mails from the hunting enthusiasts at example.com.
if header :contains "list-id" "<duck-hunting.example.com>"
{
	reject "No violence, please";
}

# The two test below are equivalent;
# The first variant is clearer and probably also more efficient.
if address :is :domain "to" "example.com" {
	fileinto "examplecom";
}
if address :matches :all "to" "*@example.com" {
	fileinto "examplecom";
}

# File mails with a Spamassassin score of 4.0 or more
# into the "junk" folder.
if header :contains "x-spam-level" "****" {
	fileinto "junk";
}


# Reject all messages that contain the string "viagra"in the Subject.
if header :contains "subject" "viagra"
{
	reject "go away!";
}
# Silently discard all messages sent from the tax man
elsif address :matches :domain "from" "*hmrc.gov.uk"
{
	discard;
}

# A mail to any of the recipients in the list of strings is filed to the folder "friends".
if address :is "from" ["daffy.duck@example.com", "porky.pig@example.com", "speedy.gonzales@example.com"] {
	fileinto "friends";
}
# Match "from" or the "sender" file with any of Daffy, Porky or Speedy.
if address :is ["from", "sender"] ["daffy.duck@example.com", "porky.pig@example.com", "speedy.gonzales@example.com"] {
	fileinto "friends";
}

# This test checks against Spamassassin's header fields:
# If the spam level ls 4 or more and the Subject contains too
# many illegal characters, then silently discard the mail.
if allof (header :contains "X-Spam-Level" "****",
          header :contains "X-Spam-Report" "FROM_ILLEGAL_CHARS") {
	discard;
}
# Discard mails that do not have a Date: or From: header field
# or mails that are sent from the marketing department at example.com.
elsif anyof (not exists ["from", "date"],
             header :contains "from" "marketing@example.com") {
	discard;
}
