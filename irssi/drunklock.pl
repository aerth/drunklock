use strict;
use warnings;
use vars qw($VERSION %IRSSI);
use Irssi;
$VERSION = '1.0';
%IRSSI = (
  authors     => 'aerth',
  name        => 'drunklock',
  description => 'Lock input when cat is on keyboard',
  license     => 'MIT',
);
my $is_drunk = 0;
sub cmd_drunk {
  my ($data, $server, $witem) = @_;
  $is_drunk = 1;
  if ($witem){
	$witem->print("\00304[drunk] Input is locked. Use /undrunk to unlock.");
  } else {
	Irssi::print("\00304[drunk] Input is locked. Use /undrunk to unlock.");
  }
}
sub cmd_undrunk {
  my ($data, $server, $witem) = @_;
  $is_drunk = 0;
  if ($witem){
	$witem->print("\00303[undrunk] Typing is unlocked.");
  } else {
	Irssi::print("\00303[undrunk] Typing is unlocked.");
  }
}
sub sig_send_text {
  my ($text, $server, $item) = @_;
  if ($is_drunk) {
	if ($item){
	  $item->print("\00304[drunk] Input is locked. Use /undrunk to unlock.");
	} else {
	  Irssi::print("\00304[drunk] Input is locked. Use /undrunk to unlock.");
	}
	Irssi::signal_stop();
  }
}
Irssi::command_bind('drunk', 'cmd_drunk');
Irssi::command_bind('undrunk', 'cmd_undrunk');
Irssi::signal_add('send text', 'sig_send_text');
Irssi::print("\00303[drunk] DrunkLock loaded. Type /drunk to lock input, /undrunk to unlock.");
