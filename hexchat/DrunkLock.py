import hexchat

__module_name__ = "DrunkLock"
__module_author__ = "aerth"
__module_version__ = "1.0"
__module_description__ = "Lock input when cat is on keyboard"

locked = True
def eat_all_input(word, word_eol, userdata):
    if locked:
        hexchat.prnt("\00304[drunk] Input is locked. Use /undrunk to unlock.")
        return hexchat.EAT_ALL
    return hexchat.EAT_NONE

def handle_drunk(word, word_eol, userdata):
    global locked
    locked = True
    hexchat.prnt("\00304[drunk] Typing is locked. Use /undrunk to unlock.")
    return hexchat.EAT_ALL

def handle_undrunk(word, word_eol, userdata):
    global locked
    locked = False
    hexchat.prnt("\00303[undrunk] Typing is unlocked.")
    return hexchat.EAT_ALL

hexchat.hook_command("", eat_all_input) # eat all
hexchat.hook_command("drunk", handle_drunk, help="/drunk - lock typing")
hexchat.hook_command("undrunk", handle_undrunk, help="/undrunk - unlock typing")

hexchat.prnt("\00303[drunk] DrunkLock loaded. Type /drunk to lock input, /undrunk to unlock.")
