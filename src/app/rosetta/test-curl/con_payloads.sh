#!/bin/bash

. lib.sh

req '/construction/payloads' '{"network_identifier": { "blockchain": "mina", "network": "devnet" }, "operations": [{"operation_identifier":{"index":0},"related_operations":[],"type":"fee_payment","status":"Pending","account":{"address":"B62qkUHaJUHERZuCHQhXCQ8xsGBqyYSgjQsKnKN5HhSJecakuJ4pYyk","metadata":{"token_id":"1"}},"amount":{"value":"-2000000000","currency":{"symbol":"MINA","decimals":9}}},{"operation_identifier":{"index":1},"related_operations":[],"type":"payment_source_dec","status":"Pending","account":{"address":"B62qkUHaJUHERZuCHQhXCQ8xsGBqyYSgjQsKnKN5HhSJecakuJ4pYyk","metadata":{"token_id":"1"}},"amount":{"value":"-3000000000","currency":{"symbol":"MINA","decimals":9}}},{"operation_identifier":{"index":2},"related_operations":[{"index":1}],"type":"payment_receiver_inc","status":"Pending","account":{"address":"B62qoDWfBZUxKpaoQCoFqr12wkaY84FrhxXNXzgBkMUi2Tz4K8kBDiv","metadata":{"token_id":"1"}},"amount":{"value":"3000000000","currency":{"symbol":"MINA","decimals":9}}}], "metadata":{"sender":"B62qkUHaJUHERZuCHQhXCQ8xsGBqyYSgjQsKnKN5HhSJecakuJ4pYyk","nonce":"2","token_id":"1","receiver": "B62qoDWfBZUxKpaoQCoFqr12wkaY84FrhxXNXzgBkMUi2Tz4K8kBDiv", "valid_until": "10000000", "memo": "hello"}, "public_keys": []}'
