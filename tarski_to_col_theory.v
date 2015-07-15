Require Export Ch06_out_lines.
Require Import tactics_axioms.

(** In this file we prove that Tarski neutral dimensionless is a Col_theory. *)

Section Tarski_is_a_Col_theory.

Context `{MT:Tarski_neutral_dimensionless}.
Context `{EqDec:EqDecidability Tpoint}.

Global Instance Tarski_is_a_Col_theory : (Col_theory Tpoint Col).
Proof.
exact (Build_Col_theory Tpoint Col col_trivial_1 col_permutation_1 col_permutation_5 col3).
Defined.

End Tarski_is_a_Col_theory.