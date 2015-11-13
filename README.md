# open_call_cookbook
[![Build Status](https://travis-ci.org/fdibartolo/open_call_cookbook.svg?branch=master)](https://travis-ci.org/fdibartolo/open_call_cookbook)

This chef cookbook can be used to provision a ready-to-use virtual box machine to work on the [open_call](https://github.com/nicopaez/opencall) project

## Supported Platforms

* Ubuntu 12.04

## Requirements

You must have:

* [Vagrant](https://www.vagrantup.com/)

* [Chef Development Kit](https://downloads.chef.io/chef-dk/)

* [Vagrant Omnibus](https://github.com/chef/vagrant-omnibus) plugin

    `$ vagrant plugin install vagrant-omnibus`

* [Vagrant Berkshelf](https://github.com/berkshelf/vagrant-berkshelf) plugin

    `$ vagrant plugin install vagrant-berkshelf`

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['open_call']['ruby_version']</tt></td>
    <td>String</td>
    <td>Ruby version to install and make default</td>
    <td><tt>2.2.1</tt></td>
  </tr>
  <tr>
    <td><tt>['open_call']['ruby_gems']</tt></td>
    <td>Array</td>
    <td>Ruby gems to install, each array element is a hash where key is gem name and value is gem version</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['open_call']['elasticsearch_version']</tt></td>
    <td>String</td>
    <td>ElasticSearch version to install</td>
    <td><tt>1.4.5</tt></td>
  </tr>
  <tr>
    <td><tt>['open_call']['elasticsearch_path']</tt></td>
    <td>String</td>
    <td>ElasticSearch path to install into</td>
    <td><tt>/usr/local</tt></td>
  </tr>
</table>

## Use it from your own vagrant file

Include `open_call` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[open_call::default]",
    "recipe[open_call::repo]" // -> skip if dont want to clone repo and prepare env (database, elasticsearch)
  ]
}
```
