# frozen_string_literal: true

#
# Author: Emilien Macchi <emilien.macchi@enovance.com>
#

Puppet::Type.newtype(:mongodb_shard) do
  @doc = 'Manage a MongoDB Shard'

  ensurable do
    desc 'Ensurable property'
    defaultto :present

    newvalue(:present) do
      provider.create
    end
  end

  newparam(:name) do
    desc 'The name of the shard'
  end

  newproperty(:member) do
    desc 'The shard member'
  end

  newproperty(:keys, array_matching: :all) do
    desc 'The sharding keys'

    def insync?(is)
      is.sort == should.sort
    end
  end

  autorequire(:package) do
    'mongodb_client'
  end

  autorequire(:service) do
    %w[mongodb mongod]
  end
end
