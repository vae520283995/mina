open Marlin_plonk_bindings_types

type t =
  ( Marlin_plonk_bindings_pasta_fp.t
  , Marlin_plonk_bindings_pasta_vesta.Affine.t
  , Marlin_plonk_bindings_pasta_fp_urs.Poly_comm.t )
  Plonk_proof.t

(* TODO-someday: [prev_challenges] should be an array of arrays, not a flat array. *)
external create :
     Marlin_plonk_bindings_pasta_fp_index.t
  -> primary_input:Marlin_plonk_bindings_pasta_fp_vector.t
  -> auxiliary_input:Marlin_plonk_bindings_pasta_fp_vector.t
  -> prev_challenges:Marlin_plonk_bindings_pasta_fp.t array
  -> prev_sgs:Marlin_plonk_bindings_pasta_vesta.Affine.t array
  -> t = "caml_pasta_fp_plonk_proof_create"

external verify :
     Marlin_plonk_bindings_pasta_fp_urs.Poly_comm.t array
  -> Marlin_plonk_bindings_pasta_fp_verifier_index.t
  -> t
  -> bool = "caml_pasta_fp_plonk_proof_verify"

external batch_verify :
     Marlin_plonk_bindings_pasta_fp_urs.Poly_comm.t array array
  -> Marlin_plonk_bindings_pasta_fp_verifier_index.t array
  -> t array
  -> bool = "caml_pasta_fp_plonk_proof_batch_verify"

external dummy : unit -> t = "caml_pasta_fp_plonk_proof_dummy"

external deep_copy : t -> t = "caml_pasta_fp_plonk_proof_deep_copy"

let%test "deep_copy" =
  let x = dummy () in
  deep_copy x = x

let%test "access elements" =
  let ({ messages; _ }
        : ( Marlin_plonk_bindings_pasta_fp.t
          , Marlin_plonk_bindings_pasta_vesta.Affine.t
          , Marlin_plonk_bindings_pasta_fp_urs.Poly_comm.t )
          Plonk_proof.t) =
    dummy ()
  in
  let ({ l_comm; _ }
        : Marlin_plonk_bindings_pasta_fp_urs.Poly_comm.t Plonk_proof.Messages.t)
      =
    messages
  in
  let ({ unshifted; shifted }
        : Marlin_plonk_bindings_pasta_vesta.Affine.t
          Marlin_plonk_bindings_types.Poly_comm.t) =
    l_comm
  in
  let _x = unshifted.(0) in
  ( match shifted with
  | None ->
      ()
  | Some x -> (
      match x with
      | Infinity ->
          ()
      | Finite (x, y) ->
          let open Marlin_plonk_bindings_pasta_fq in
          ignore (to_string x, to_string y) ) ) ;
  true
