from sys import argv, stderr
from telnetlib import Telnet
from subprocess import run
REFLECT = True
UGLY = '/private/tftpboot/ugly'

argv.append('192.168.0.86')

t = Telnet(argv[1])

def getprompt():
    if REFLECT: print('[GETTING PROMPT]')
    ls = t.read_until(b'# ')[:-2].replace(b'\r',b'').decode('ascii').split('\n')
    if REFLECT:
        for l in ls:
            if not l: continue
            print('[PREPROMPT]', l)
        print('[PROMPT]')
    return ls

def mkdir_p(*d):
    d = '/'.join(d)
    if d in '.': return
    run(['mkdir', '-p', '--', d])

def cmd(s):
    if REFLECT: print('[SEND]', s)
    t.write(s.encode('ascii') + b'\n')
    print('[REFLECT]', t.read_until(b'\r\n')[:-2].decode('ascii'))

t.read_until(b': ')
t.write(b'admin\n')
t.read_until(b': ')
t.write(b'admin\n')

getprompt()


def explore(path):
    print(path)
    mkdir_p(*path)
    path_str = '/'.join(path) + '/'

    cmd('ls -la -- ' + path_str)
    ls_lines = getprompt()
    if ls_lines and ' ' not in ls_lines[0]: ls_lines.pop(0)
    for l in ls_lines:
        if not l: continue
        if l.endswith(' ..') or l.endswith(' .'): continue

        # print(l)
        drwx, _, o, g, size, *namel = l.split()
        size = int(size)
        name = namel[0]
        pname = '/'.join(path + [name])

        firstlet = drwx[0]

        if firstlet == 'd':
            explore(path + [name])
        elif firstlet == '-':
            cmd('tftp -l "%s" -r ugly -p 192.168.0.17' % pname)
            getprompt()
            run(['cp', UGLY, pname])

        elif firstlet == 'l':
            run(['ln', '-f', '-s', namel[2], pname])

run(['touch', UGLY])
run(['chmod', '777', UGLY])

# You will need to copy init separately
for f in 'sbin bin home etc_ro var lib usr tmp etc opt'.split():
    explore([f])
