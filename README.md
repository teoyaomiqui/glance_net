glance_net
============

Plugin description

This plugin is designed to redirect image ralated(glance) network traffic away from management network.

Requirement:
  - Install plugin 'fuel plugins --install <rpm file>'
  - New network-group called 'glance' has to to be created in fuel CLI:
      - find out your node-group id with the following command:
          - 'fuel network-group'
      - create new network-group, example command:
          - 'fuel network-group --create --node-group=<enter your node-group id> --name='glance' --cidr=10.109.16.0/24'

In this build plugin does the following:

  - Creates network interfaces connected to the new, previously created network, named glance;

  - Creates new virtual ip address (glance_vip) on glance network and puts it in haproxy namespace;

  - Overrides current keystone endpoint for glance service, setting it's internal and admin ip address to glance network;
  
  - Configures virtual ip (glance_vip) backends to glance-api servers that are located on glance network (created previously);

  - Reconfigures nova and cinder services to use new glance-api endpoint 
