# open_call_cookbook

This chef cookbook can be used to provision a ready-to-use virtual box machine to work on the [open_call](https://github.com/nicopaez/opencall) project

## Supported Platforms

* Ubuntu 12.04

## Requirements

* Install [Vagrant](https://www.vagrantup.com/)

* Add [Omnibus](https://github.com/chef/vagrant-omnibus) plugin

    `$ vagrant plugin install vagrant-omnibus`

* Add [Berkshelf](https://github.com/berkshelf/vagrant-berkshelf) plugin

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
    <td><tt>['open_call']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Use it from your own vagrant file

Include `open_call` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[open_call::default]"
  ]
}
```
