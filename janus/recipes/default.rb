# Cookbook Name:: janus
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Install the required packages for Janus
node['janus']['required_packages'].each do |pkg|
  package pkg
end

# Execute the Janus bootstrap installation from github.
execute "curl -Lo- http://bit.ly/janus-bootstrap | bash" do
  cwd   node['janus']['dir']
  user  node['janus']['user']
  not_if {File.exists?("/home/#{node['janus']['user']}/.vim/bootstrap.sh")}
end

user_id = node['janus']['user']

template "/home/#{user_id}/.vimrc.after" do
  source "vimrc.after"
  owner user_id
  group user_id
  action :create_if_missing
end