# Tiny docker-compose service for SSH port forwarding

Use this service to deploy tiny openssh-based service and use it to securely connect two machines behind NAT via SSH port forwarding.

Copy files from this repo to docker-enabled publicly accessible server `example.com`. Create `authorized_keys` file and put your SSH public keys from both machines there. If neccessary, edit port and host in `docker-compose.yaml`. Start service via `docker-compose up --build -d`.

Connect service from `machine1` and expose its port `1234` via reverse port forwarding:

    machine1:~$ ssh -p 2222 tunnel@example.com -R 127.0.0.1:2222:127.0.0.1:1234 -N

Connect service from `machine2` and use SSH port forwarding to link one of it's local ports to port 22 of `machine1`:

    machine2:~$ ssh -p 2222 tunnel@example.com -L 127.0.0.1:1234:127.0.0.1:2222 -N

Now any connection to `127.0.0.1:1234` on `machine1` will be forwarded to `127.0.0.1:1234` on `machine2`.
