(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Operation.t : Operations contain all balance-changing information within a transaction. They are always one-sided (only affect 1 AccountIdentifier) and can succeed or fail independently from a Transaction. Operations are used both to represent on-chain data (Data API) and to construct new transactions (Construction API), creating a standard interface for reading and writing to blockchains.
 *)

type t =
  { operation_identifier : Operation_identifier.t
  ; (* Restrict referenced related_operations to identifier indices < the current operation_identifier.index. This ensures there exists a clear DAG-structure of relations. Since operations are one-sided, one could imagine relating operations in a single transfer or linking operations in a call tree. *)
    related_operations : Operation_identifier.t list option [@default None]
  ; (* Type is the network-specific type of the operation. Ensure that any type that can be returned here is also specified in the NetworkOptionsResponse. This can be very useful to downstream consumers that parse all block data. *)
    _type : string [@key "type"]
  ; (* Status is the network-specific status of the operation. Status is not defined on the transaction object because blockchains with smart contracts may have transactions that partially apply (some operations are successful and some are not). Blockchains with atomic transactions (all operations succeed or all operations fail) will have the same status for each operation. On-chain operations (operations retrieved in the `/block` and `/block/transaction` endpoints) MUST have a populated status field (anything on-chain must have succeeded or failed). However, operations provided during transaction construction (often times called \''intent\'' in the documentation) MUST NOT have a populated status field (operations yet to be included on-chain have not yet succeeded or failed). *)
    status : string option [@default None]
  ; account : Account_identifier.t option [@default None]
  ; amount : Amount.t option [@default None]
  ; coin_change : Coin_change.t option [@default None]
  ; metadata : Yojson.Safe.t option [@default None]
  }
[@@deriving yojson { strict = false }, show, eq]

(** Operations contain all balance-changing information within a transaction. They are always one-sided (only affect 1 AccountIdentifier) and can succeed or fail independently from a Transaction. Operations are used both to represent on-chain data (Data API) and to construct new transactions (Construction API), creating a standard interface for reading and writing to blockchains. *)
let create (operation_identifier : Operation_identifier.t) (_type : string) : t
    =
  { operation_identifier
  ; related_operations = None
  ; _type
  ; status = None
  ; account = None
  ; amount = None
  ; coin_change = None
  ; metadata = None
  }