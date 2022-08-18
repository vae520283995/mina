(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Construction_hash_request.t : ConstructionHashRequest is the input to the `/construction/hash` endpoint.
 *)

type t =
  { network_identifier : Network_identifier.t; signed_transaction : string }
[@@deriving yojson { strict = false }, show, eq]

(** ConstructionHashRequest is the input to the `/construction/hash` endpoint. *)
let create (network_identifier : Network_identifier.t)
    (signed_transaction : string) : t =
  { network_identifier; signed_transaction }
