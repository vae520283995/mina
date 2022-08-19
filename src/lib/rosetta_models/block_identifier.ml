(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Block_identifier.t : The block_identifier uniquely identifies a block in a particular network.
 *)

type t =
  { (* This is also known as the block height. *)
    index : int64; hash : string }
[@@deriving yojson { strict = false }, show, eq]

(** The block_identifier uniquely identifies a block in a particular network. *)
let create (index : int64) (hash : string) : t = { index; hash }
