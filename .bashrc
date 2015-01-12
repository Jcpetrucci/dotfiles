# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Some DNS setup for alias 'dns'
export dnsptrgen=$(mktemp)
cat <<'EOF' > $dnsptrgen && chmod +x $dnsptrgen
awk '/TTL/,/main/' /var/named/jcp > /var/named/named.10.13
awk '$2 == "A" && $1 !~ "^;" {printf "%s\t PTR\t %s.jcp\n", $3, $1;}' /var/named/jcp | sed -r 's/[0-9]+\.[0-9]+\.([0-9]+)\.([0-9]+)/\2.\1/' >> /var/named/named.10.13
EOF

# User specific aliases and functions
alias rm='rm -v'
alias less='less -iS'
alias dns='sudo vi /var/named/jcp; sudo bash -x "$dnsptrgen"; sudo service named reload'
alias p='~/phonetic.sh' # http://johncpetrucci.com/archive/phonetic.sh
alias md5='echo Use sha instead.'
alias sha='cat <<EOF | grep -Ei "file|sha\-1" | tr -d "\n" | sed -re "/File|SHA\-1/{s/[ ]*File/Received file/g;s/[ ]*SHA-1(.*)/ \(SHA\-1\1\)/g}"; echo '
alias rdp='ssh -fgN -L 3389:192.168.59.10:3389 admin@c1.jcp'

s (){
	dnsFile=/var/named/jcp
	colorsonred=$(tput setaf 1)
	colorsongreen=$(tput setaf 2)
	colorsoff=$(tput sgr0)
	possibleHostArray=($(awk '$2 == "A" && $0 !~ ";hide$" {print $1}' $dnsFile | \
		grep -vE "^;" | \
		sort))

	clear
	printf '%s\n\n' "Select a host to SSH to:"

	for (( i = 0; i < ${#possibleHostArray[*]}; i++ ));
	do
		hostname=${possibleHostArray[$i]}
		ip=$(dig +short ${possibleHostArray[$i]}.jcp )
		upcheck="${colorsonred}DOWN${colorsoff}"
		#timeout 1 nc -dz ${possibleHostArray[$i]}.jcp 22 >/dev/null 2>&1 && export upcheck="${colorsongreen}_UP_${colorsoff}"
		#needs to hang if host is down and exit quickly if host is up:
                #{ nc -w 3 -i 0.001 --recv-only ${possibleHostArray[$i]}.jcp 22 & } >/dev/null 2>&1
		{ nc -dz ${possibleHostArray[$i]}.jcp 22 & } >/dev/null 2>&1
		disown
		kidpid=$!
		sleep 0.005
		ps $kidpid >/dev/null 2>&1 || upcheck="${colorsongreen} UP ${colorsoff}"
		printf '%2d) [ %s ] %s (%s)\n' "$i" "$(echo -e $upcheck)" "${hostname}" "${ip}" 
	done

	read -p "Host # or name: "
	[[ -n $REPLY ]] || return;

	sshHost=$REPLY
	grep -Eq "[^0-9]" <<< "$REPLY" || sshHost=${possibleHostArray[$REPLY]}
	printf '%s ' "Now going to execute the command:" 
	bash -xc "ssh -o 'VisualHostKey=yes' ${sshHost}.jcp"
}

export PS1='\u.$?\$ '
export EDITOR='vi'
