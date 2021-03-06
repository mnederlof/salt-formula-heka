-- Copyright 2016 Mirantis, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
local dt     = require "date_time"
local l      = require 'lpeg'
l.locale(l)

local patt   = require 'patterns'
local utils  = require 'lma_utils'

local tonumber = tonumber

local M = {}
setfenv(1, M) -- Remove external access to contain everything in the module

local message   = l.Cg(patt.Message, "Message")

-- Complete grammars

-- Zookeeper
-- 2016-11-21 06:38:43,081 - INFO  [main:Environment@100] - Server environment:java.io.tmpdir=/tmp
ZookeeperLogGrammar = l.Ct(patt.JavaTimestamp * patt.sp * patt.dash * patt.sp * patt.JavaSeverity * patt.sp^1 * message)

-- Cassandra
-- 2016-11-21 08:52:14,070 - DEBUG - run_command: nodetool -h 127.0.0.1 info | grep ID | awk '{print $3}'
CassandraLogGrammar = l.Ct(patt.JavaTimestamp * patt.sp * patt.dash * patt.sp * patt.JavaSeverity * patt.sp^1 * patt.dash * patt.sp * message)

-- Ifmap
-- 2016-11-24 10:11:32,457 - TRACE - [main]  - MetadataTypeRepository: new MetadataType http://www.trustedcomputinggroup.org/2010/IFMAP-METADATA/2:discovered-by - singleValue
IfmapLogGrammar = CassandraLogGrammar

return M
