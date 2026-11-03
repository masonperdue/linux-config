
# SystemD

List User Services:
systemctl --user list-units --type=service --all --no-pager

View User Logs:
journalctl -xe
journalctl --user -exfu [service name]
