#!/bash
#server local time
VPS_TIME='Asia/Manila'
function 
 export DEBIAN_FRONTEND=noninteractive
 apt-get  0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 1
forwarded-connect-retries 1
accept-intercepted-requests 1
allow-cgi-request-crunching 1
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
permit-access 0.0.0.0/0 IP-ADDRESS
myPrivoxy
    }
privoxy

 # Setting machine's IP Address inside of our privoxy config(security that only allows this machine to use this proxy server)
 sed -i "s|IP-ADDRESS|$IPADDR|g" /etc/privoxy/config
 :d8:ba:fb:
                    fe:35:b3:6b:e7:ef:35:08:93:93:99:f1:8c:9a:7d:
                    4c:33:a1:03:a6:be:fc:0c:8f:fd:09:41:18:2d:4c:
AQUFBwMBMAsGA1UdDwQEAwIFoDARBgNVHREECjAIggZzZXJ2ZXIwDQYJKoZIhvcN
AQELBQADggEBADzYSCyvaKr2vFvHg2uUGxipAc6n+BPJY1nUgqWmarWmdk6YaSV4
8NmWM7/WMoC2Ts6ScZxXC2Tb+FP52MzC/YBQt33Tqo/graPBRhlwTLYasc/UjKA5
iYcslGWQyaz+uC+umKcSjijDxSQQ6gn20Jczd50TzxwYTimpBZFXxKs+gjJEzIEd
NS3HGciTq/w24ob7NJYwa+eQw3REny739qOuEawq5hb5LH71
wNEW0gFvVJ0cCLY6eaN+hoPuq973YyTVxJtDtuM3IKWLuc8Togep7+Xih4kDCRxw
PebJ0Z0am6eCgkUI+rFd5AXUGmphZdLVYyA=
-----END CERTIFICATE-----
EOF2
#server.key HERE
cat <<EOF3>> /etc/openvpn/easy-rsa/keys/server.key #/usr/share/doc/openvpn/examples/sample-keys/server.key
-----BEGIN PRIVATE KEY-----
MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQC/rlDXzTx3kK69
Nm0gQILzb8PRWj8hIusgrRPbw66xOdQLurnxeTUEp5Vl2TiuuLDbrdUH/POQIqSc
WyKfgaqWj75fp2eGYjGuvBebm+fWbhVHOs4hZ1E+yHpAnrCOu79tx9sStWYxvUrB
zf78dgihWtt731xsjNCF8dDNggzovCTNaWpPkzRDKPqnHA9w3SXJ1ENsSQOn/8em
CJJVNpGYVM2yP20SI/DUCAbclE9uuNi6+/41s2vn7zUIk5OZ8YyafUwzoQOmvvwM
j/0JQRgtTHhKq2yvgqozn7M0LDIvml5xa4EVWP9IoG3RSOcZdxnMFQmBeF8Olvyo
Xp0FM6jxAgMBAAECggEBAIwudq8sSLGEnVaBjFNO+rYAIexknNCmEeEm0uQg+wxf
p2UgnUYtB4os6UTAFQUqyyUNv0OFSbc6rrouqGaQ1Oohm++mpT6RZ5ZLttQ1s9qN
TYB3UDL7tV4+DbJem+72/avSwrOu+Fsd/aM4/Oczh2JB6UxxcM1uOj4LOFJjbv9w
/FXbCVLn6OeqjFzSRtOiPshlXQHENvEYRDiYkmGeNsr5iHwvXYWYe+4i0/sLXDWj
A1vuiCASNKm9CIkegAp0RgzI/rCA2eQbtpt+hW+qwWptDRxnPyF2Y/g0cT0vMY8f
T1gMlsu1bmbxN67Z8Iy6um1t+AG8njQyDQbQqCQV2dUCgYEA74GzI6wRTfz0LFO9
7Srzp1o5UClPf01gSdmGL7WkO8/aQMPSzlTgwWQG2WFQqb9L3vsBzcKfor6Bf/5L
LiwLfne5JWpJ5tYylht0RgKXmVm+JgiT0fRw5bUwbahwSeqKsvdN07qXmO9Z86EK
z+hD1lZd49B+6dJEYFME0UPfOwsCgYEAzOF9KUHC96mHiULzYAuBW+VnyM8NfUvs
PkVd1HiArhwvTlw8S03ZgDcMBmv3EuyXoXWo8uN5+Gkik3AJ2BsXgcto/Bt8Toqv
7J1V7e7SuVVS9hkcwt3HgC/fo183xZp9VsH+RuGgMVh9/v9zz4Jelzx6BRLvRyLt
2jp0OX4CSXMCgYEAv5H6e5nx7XNayungjIdChKWCGkAwuh5l2iwHTLn5N241oIAB
adAyRf2ADPft0RiV0zDqbG4zybSfWIVKFRBd0TZp/SdbHSxPIgmroyQHpj1F/p31
voXKl7GpnsyPpE/ZyPROaABjqYwpYtl5EHszZ4mFZ+co3FW3I2TEAa5MK6kCgYEA
pQAEeLGJf0N88EKHFpate4DpcIOv7XSzsgLTakYR/CaewpDtzgfIXsX2XUWeGhOI
mnPTuKkSlci2G99jTjOjXtiemEradbajr/+WMKTh+HiK87+NtjI+dTIY/c21cOLW
hoR9cEBNbvBBqJe6gSgRXeNKscNqCPRMcjAZYiPlW5kCgYEAhN8utwfoJpy0DfNh
v9VJLWEMPuBUbMMOuR119P8YArNPPx7PTXi4XzbPv7rf99lfuizXZBzmGjKqEOWH
EMtP6kaosO6oZcU6L3w8izeFqYFn+hxL9DENC11xKpCoqFkYKNkKuqghi9KIjoVt
TVxXp5vGwz5umT+nrSnjrkgO6h8=
-----END PRIVATE KEY-----
EOF3
#singin the server key using CA
openssl "

daemon
user nobody
group nogroup
log-append /var/log/openvpn.log
verb 2
EOF4
#start openvpn
systemctl start openvpn@server
systemctl enable openvpn@server
#generate client configurstion
cat <<EOF5> /etc/openvpn/client/client.ovpn
client
dev tun
proto tcp
remote vpn-server-ip $openvpn_port
ca ca.crt
cert client.crt
key client.key
cipher AES-256-CBC
auth SHA512
auth-nocache
tls-version-min 1.2
tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-128-CBC-SHA256
resolv-retry infinite
compress lz4
nobind
persist-key
persist-tun
mute-replay-warnings
verb 2
EOF5
systemctl status openvpn@server
}
openvpn
