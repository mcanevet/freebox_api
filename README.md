Freebox OS API bindings for Ruby
================================

WARNING: Work In Progress.

Overview
--------

This gem contains Freebox OS API bindings for the Ruby language.
I started working on that to use it with https://github.com/mcanevet/puppet-freebox.

The official documentation is located here: http://dev.freebox.fr/sdk/os/

Building the Freebox object
---------------------------

```ruby
require 'freebox_api'

myFreebox = FreeboxApi::Freebox.new
```

or

```ruby
require 'freebox_api'

myFreebox = FreeboxApi::Freebox.new({
  :freebox_ip   => 'mafreebox.example.com',
  :freebox_port => 4242,
})
```

Login
-----

### Obtaining an app\_token

#### Request authorization

This is the first step, the app will ask for an app\_token using the following call. A message will be displayed on the Freebox LCD asking the user to grant/deny access to the requesting app.

Once the app has obtained a valid app\_token, it will not have to do this procedure again unless the user revokes the app\_token.

```ruby
token_request = {
  :app_id      => 'fr.freebox.testapp',
  :app_name    => 'Test App',
  :app_version => '0.0.7',
  :device_name => 'Pc de Xavier'
}

auth_request = myFreebox.authorize(token_request)

app_token = auth_request['app_token']
```

### Creating the session object

```ruby
myApp = {
  :app_id      => 'fr.freebox.testapp',
  :app_version => '0.0.7',
  :app_token   => 'dyNYgfK0Ya6FWGqq83sBHa7TwzWo+pg4fDFUJHShcjVYzTfaRrZzm93p7OTAfH/0',
}
mySession = FreeboxApi::Session.new(myApp, myFreebox)
```

or

```ruby
mySession = FreeboxApi::Session.new({
  :app_id      => 'fr.freebox.testapp',
  :app_version => '0.0.7',
  :app_token   => 'dyNYgfK0Ya6FWGqq83sBHa7TwzWo+pg4fDFUJHShcjVYzTfaRrZzm93p7OTAfH/0',
}, FreeboxApi::Freebox.new)
```

Reference
---------

```ruby
config = FreeboxApi::Config.new(mySession)
```

### Connection API

#### Connection status

##### Get the current Connection status
[ ] GET /api/v1/connection/

#### Connection configuration

##### Get the current Connection configuration
[X] GET /api/v1/connection/config/

```ruby
config.show('connection')
```

##### Update the Connection configuration
[X] PUT /api/v1/connection/config/

```ruby
config.update('connection', {
  :ping => true,
  :wol  => false,
})
```

#### Connection IPv6 configuration

##### Get the current IPv6 Connection configuration
[X] GET /api/v1/connection/ipv6/config/

```ruby
config.show('ipv6')
```

##### Update the IPv6 Connection configuration
[X] PUT /api/v1/connection/ipv6/config/

```ruby
config.update('ipv6', {
  :delegations => [
    {
     :prefix   => '2a01:e30:d252:a2a2::/64',
     :next_hop => 'fe80::be30:5bff:feb5:fcc7',
    }
  ]
})
```

#### Connection DynDNS status

##### Get the status of a DynDNS service
[ ] GET /api/v1/connection/ddns/{provider}/status/

#### Connection DynDNS configuration

##### Get the config of a DynDNS service
[X] GET /api/v1/connection/ddns/{provider}/

```ruby
config.show('ddns/dyndns')
```

##### Set the config of a DynDNS service
[X] PUT /api/v1/connection/ddns/{provider}/

```ruby
config.update('ddns/dyndns', {
  :enabled  => false,
  :user     => 'test',
  :password => 'ssss',
  :hostname => 'ttt',
})
```

### Lan

#### Lan Config API

##### Get the current Lan configuration
[X] GET /api/v1/lan/config/

```ruby
config.show('lan')
```

##### Update the current Lan configuration
[X] PUT /api/v1/lan/config/

```ruby
config.update('lan', {
  :mode         => 'router',
  :ip           => '192.168.69.254',
  :name         => 'Freebox de r0ro',
  :name_dns     => 'freebox-de-r0ro',
  :name_mdns    => 'Freebox-de-r0ro',
  :name_netbios => 'Freebox_de_r0ro',
})
```

### Lan Browser

#### Lan Browser API

##### Getting the list of browsable LAN interfaces
[X] GET /api/v1/lan/browser/interfaces/

```ruby
interfaces = FreeboxApi::Resources::Interface.new(mySession)
interfaces.index
```

##### Getting the list of hosts on a given interface
[X] GET /api/v1/lan/browser/{interface}/

```ruby
lan_hosts = FreeboxApi::Resources::LanHost.new(mySession)
lan_hosts.index
```

##### Getting an host information
[X] GET /api/v1/lan/browser/{interface}/{hostid}/

```ruby
lan_hosts.show('ether-00:24:d4:7e:00:4c')
```

##### Updating an host information
[X] PUT /api/v1/lan/browser/{interface}/{hostid}/

```ruby
lan_hosts.update({
  :id           => 'ether-00:24:d4:7e:00:4c',
  :primary_name => 'Freebox Tv',
})
```

#### Wake on LAN

##### Send Wake ok Lan packet to an host
[ ] POST /api/v1/lan/wol/{interface}/

### Freeplug

#### Freeplug API

```ruby
freeplug_networks = FreeboxApi::Resources::FreeplugNetwork.new(session)
freeplugs = FreeboxApi::Resources::Freeplug.new(session)
```

##### Get the current Freeplugs networks
[X] GET /api/v1/freeplug/

```ruby
freeplug_networks.index
```

##### Get a particular Freeplug information
[X] GET /api/v1/freeplug/{id}/

```ruby
freeplugs.show('F4:CA:E5:1D:46:AE')
```

##### Reset a Freeplug
[X] POST /api/v1/freeplug/{id}/reset/

```ruby
freeplugs.reset('F4:CA:E5:1D:46:AE')
```

### DHCP

#### DHCP Configuration API

##### Get the current DHCP configuration
[X] GET /api/v1/dhcp/config/

```ruby
config.show('dhcp')
```

##### Update the current DHCP configuration
[X] PUT /api/v1/dhcp/config/

```ruby
config.update('dhcp', {
  :enabled => false,
})
```

#### DHCP Static Lease API

##### Get the list of DHCP static leases
[X] GET /api/v1/dhcp/static\_lease/

```ruby
static_leases = FreeboxApi::Resources::StaticLease.new(mySession)
static_leases.index
```

##### Get a given DHCP static lease
[X] GET /api/v1/dhcp/static\_lease/{id}

```ruby
static_leases.show('00:DE:AD:B0:0B:55')
```

##### Update DHCP static lease
[X] PUT /api/v1/dhcp/static\_lease/{id}

```ruby
static_leases.update({
  :id      => '00:DE:AD:B0:0B:55',
  :comment => 'Mon PC',
})
```

##### Delete a DHCP static lease
[X] DELETE /api/v1/dhcp/static\_lease/{id}

```ruby
static_lease.destroy('00:DE:AD:B0:0B:55')
```

##### Add a DHCP static lease
[X] POST /api/v1/dhcp/static\_lease/

```ruby
static_lease.create({
  :ip  => '192.168.1.222',
  :mac => '00:00:00:11:11:11',
})
```

##### Get the list of DHCP dynamic leases
[ ] GET /api/v1/dhcp/dynamic\_lease/

### Ftp

#### Ftp config API

##### Get the current Ftp configuration
[X] GET /api/v1/ftp/config/

```ruby
config.show('ftp')
```

##### Update the FTP configuration
[X] PUT /api/v1/ftp/config/

```ruby
config.update('ftp', {
  :enabled => true
})
```

### NAT

#### Dmz Config API

##### Get the current Dmz configuration
[X] GET /api/v1/fw/dmz/

```ruby
config.show('dmz')
```

##### Update the current Dmz configuration
[X] PUT /api/v1/fw/dmz/

```ruby
config.update('dmz', {
  :enabled => true,
  :ip      => '192.168.1.42',
})
```

### Port Forwarding

#### Port Forwarding API

##### Getting the list of port forwarding
[X] GET /api/v1/fw/redir/

```ruby
port_forwardings = FreeboxApi::Resources::PortForwarding.new(mySession)
port_forwardings.index
```

##### Getting a specific port forwarding
[X] GET /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.show(1)
```

##### Updating a port forwarding
[X] PUT /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.update({
  :id      => 1,
  :enabled => false,
})
```

##### Add a port forwarding
[X] POST /api/v1/fw/redir/

```ruby
port_forwardings.create({
  :enabled        => true,
  :comment        => 'test',
  :lan_port       => 4242,
  :wan_port_end   => 4242,
  :wan_port_start => 4242,
  :lan_ip         => '192.168.1.42',
  :ip_proto       => 'tcp',
})
```

##### Delete a port forwarding
[X] DELETE /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.destroy(3)
```

### UPnP IGD

#### UPnP IGD config API

##### Get the current UPnP IGD configuration
[X] GET /api/v1/upnpigd/config/

```ruby
config.show('upnpigd')
```

##### Update the UPnP IGD configuration
[X] PUT /api/v1/upnpigd/config/

```ruby
config.update('upnpigd', {
  :enabled => true,
})
```

#### UPnP IGD Redirection API

##### Get the list of current redirection
[X] GET /api/v1/upnpigd/redir/

```ruby
upnp_redir = FreeboxApi::Resources::UPnPRedir.new(mySession)
upnp_redir.index
```

##### Delete a redirection
[X] DELETE /api/v1/upnpigd/redir/{id}

```ruby
upnp_redir.destroy('0.0.0.0-53644-udp')
```

### LCD

#### LCD config API

##### Get the current LCD configuration
[X] GET /api/v1/lcd/config/

```ruby
config.show('lcd')
```

##### Update the lcd configuration
[X] PUT /api/v1/lcd/config/

```ruby
config.update('lcd', {
  :brightness => 50,
})
```

### Network Share

#### Samba config API

##### Get the current Samba configuration
[X] GET /api/v1/netshare/samba/

```ruby
config.show('samba')
```

##### Update the Samba configuration
[X] PUT /api/v1/netshare/samba/

```ruby
config.update('samba', {
  :print_share_enabled => false,
})
```

#### Afp config API

##### Get the current Afp configuration
[X] GET /api/v1/netshare/afp/

```ruby
config.show('afp')
```

##### Update the Afp configuration
[X] PUT /api/v1/netshare/afp/

```ruby
config.update('afp', {
  :guest_allow => false,
})
```

### UPnP AV

#### UPnP AV config API

##### Get the current UPnP AV configuration
[X] GET /api/v1/upnpav/config/

```ruby
config.show('upnpav')
```

##### Update the UPnP AV configuration
[X] PUT /api/v1/upnpav/config/

```ruby
config.update('upnpav', {
  :enabled => false,
})
```

### Switch

#### Switch API

##### Get the current switch status
[ ] GET /api/v1/switch/status/

##### Get a port configuration
[ ] GET /api/v1/switch/port/{id}

##### Update a port configuration
[ ] PUT /api/v1/switch/port/{id}

##### Get a port stats
[ ] GET /api/v1/switch/port/{id}/stats

### Wi-Fi

#### Wi-Fi Status API

##### Get the current Wi-Fi status
[ ] GET /api/v1/wifi/

#### Wi-Fi config API

##### Get the current Wi-Fi configuration
[X] GET /api/v1/wifi/config/

```ruby
config.show('wifi')
```

##### Update the Wi-Fi configuration
[X] PUT /api/v1/wifi/config/

```ruby
config.update('wifi', {
  :ap_params => {
    :ht_mode => 'disabled',
  }
})
```

##### Reset the Wi-Fi configuration
[ ] POST /api/v1/wifi/config/reset/

#### Wi-Fi Stations API

##### Get Wi-Fi Stations List
[ ] GET /api/v1/wifi/stations/{bss\_name}/

#### Wi-Fi MAC Filter API

##### Get the MAC filter list
[ ] GET /api/v1/wifi/mac\_filter/

##### Getting a particular MAC filter
[ ] GET /api/v1/wifi/mac\_filter/{filter\_id}

##### Updating a MAC filter
[ ] PUT /api/v1/wifi/mac\_filter/{filter\_id}

##### Delete a MAC filter
[ ] DELETE /api/v1/wifi/mac\_filter/{filter\_id}

##### Create a new MAC filter
[ ] POST /api/v1/wifi/mac\_filter/
