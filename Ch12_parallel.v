Require Export Ch11_angles.

Section T12_1.

Context `{MT:Tarski_neutral_dimensionless}.
Context `{EqDec:EqDecidability Tpoint}.

Definition Par_strict := fun A B C D =>
  A<>B /\ C<>D /\ coplanar A B C D /\ ~ exists X, Col X A B /\ Col X C D.

Definition Par := fun A B C D =>
  Par_strict A B C D \/ (A<>B /\ C<>D /\ Col A C D /\ Col B C D).

Lemma par_reflexivity : forall A B, A<>B -> Par A B A B.
Proof.
    intros.
    unfold Par.
    unfold Par_strict.
    right.
    repeat split.
      assumption.
      assumption.
      apply col_trivial_1.
    apply col_trivial_3.
Qed.


Lemma par_strict_irreflexivity : forall A B,
 ~ Par_strict A B A B.
Proof.
    intros.
    intro.
    unfold Par_strict in H.
    spliter.
    apply H2.
    exists A.
    split; apply col_trivial_1.
Qed.

Lemma not_par_strict_id : forall A B C,
 ~ Par_strict A B A C.
Proof.
    intros.
    intro.
    unfold Par_strict in H.
    spliter.
    apply H2.
    exists A.
    split; Col.
Qed.

Lemma par_id : forall A B C,
 Par A B A C -> Col A B C.
Proof.
    intros.
    unfold Par in H.
    induction H.
      unfold Par_strict in H.
      spliter.
      apply False_ind.
      apply H2.
      exists A.
      Col.
    spliter;Col.
Qed.


Lemma par_strict_not_col_1 : forall A B C D,
 Par_strict A B C D  -> ~ Col A B C.
Proof.
    intros.
    unfold Par_strict in *.
    spliter.
    intro.
    apply H2.
    exists C.
    split;Col.
Qed.


Lemma par_strict_not_col_2 : forall A B C D,
 Par_strict A B C D  -> ~ Col B C D.
Proof.
    intros.
    unfold Par_strict in *.
    spliter.
    intro.
    apply H2.
    exists B.
    split;Col.
Qed.

Lemma par_strict_not_col_3 : forall A B C D,
 Par_strict A B C D  -> ~ Col C D A.
Proof.
    intros.
    unfold Par_strict in *.
    spliter.
    intro.
    apply H2.
    exists A.
    split;Col.
Qed.

Lemma par_strict_not_col_4 : forall A B C D,
 Par_strict A B C D  -> ~ Col A B D.
Proof.
    intros.
    unfold Par_strict in *.
    spliter.
    intro.
    apply H2.
    exists D.
    split;Col.
Qed.

Lemma par_id_1 : forall A B C,
 Par A B A C -> Col B A C.
Proof.
    intros.
    assert (H1 := par_id A B C H).
    Col.
Qed.

Lemma par_id_2 : forall A B C,
 Par A B A C -> Col B C A.
Proof.
    intros.
    assert (H1 := par_id A B C H).
    Col.
Qed.

Lemma par_id_3 : forall A B C,
 Par A B A C -> Col A C B.
Proof.
    intros.
    assert (H1 := par_id A B C H).
    Col.
Qed.

Lemma par_id_4 : forall A B C,
 Par A B A C -> Col C B A.
Proof.
    intros.
    assert (H1 := par_id A B C H).
    Col.
Qed.


Lemma par_id_5 : forall A B C,
 Par A B A C -> Col C A B.
Proof.
    intros.
    assert (H1 := par_id A B C H).
    Col.
Qed.

Lemma par_strict_symmetry :forall A B C D,
 Par_strict A B C D -> Par_strict C D A B.
Proof.
    unfold Par_strict.
    intros.
    spliter.
    repeat split.
      assumption.
      assumption.
      apply coplanar_perm_16;assumption.
    intro.
    apply H2.
    ex_and H3 X.
    exists X.
    split; assumption.
Qed.

Lemma par_symmetry :forall A B C D,
 Par A B C D -> Par C D A B.
Proof.
    unfold Par.
    intros.
    induction H.
      left.
      apply par_strict_symmetry.
      assumption.
    spliter.
    right.
    repeat split;try assumption.
      eapply (col_transitivity_1 _ D);Col.
    eapply (col_transitivity_1 _ C);Col.
Qed.

Lemma par_left_comm : forall A B C D,
 Par A B C D -> Par B A C D.
Proof.
    unfold Par.
    intros.
    induction H.
      left.
      unfold Par_strict in *.
      spliter.
      repeat split.
        auto.
        assumption.
        apply coplanar_perm_6;assumption.
      intro.
      apply H2.
      ex_and H3 X.
      exists X.
      Col5.
    right.
    spliter.
    Col5.
Qed.

Lemma par_right_comm : forall A B C D,
 Par A B C D -> Par A B D C.
Proof.
    intros.
    apply par_symmetry in H.
    apply par_symmetry.
    apply par_left_comm.
    assumption.
Qed.

Lemma par_comm : forall A B C D,
 Par A B C D -> Par B A D C.
Proof.
    intros.
    apply par_left_comm.
    apply par_right_comm.
    assumption.
Qed.

Lemma par_strict_left_comm : forall A B C D,
 Par_strict A B C D -> Par_strict B A C D.
Proof.
    unfold Par_strict.
    intros.
    decompose [and] H;clear H.
    repeat split.
      intuition.
      assumption.
      apply coplanar_perm_6;assumption.
    intro.
    apply H4.
    destruct H as [X [HCol1 HCol2]].
    exists X; Col.
Qed.

Lemma par_strict_right_comm : forall A B C D,
 Par_strict A B C D -> Par_strict A B D C.
Proof.
    unfold Par_strict.
    intros.
    decompose [and] H;clear H.
    repeat split.
      assumption.
      intuition.
      apply coplanar_perm_1;assumption.
    intro.
    apply H4.
    destruct H as [X [HCol1 HCol2]].
    exists X; Col.
Qed.

Lemma par_strict_comm : forall A B C D,
 Par_strict A B C D -> Par_strict B A D C.
Proof.
    intros.
    apply par_strict_left_comm in H.
    apply par_strict_right_comm.
    assumption.
Qed.

End T12_1.

Hint Resolve
 par_reflexivity par_strict_irreflexivity
 par_strict_symmetry par_strict_comm par_strict_right_comm par_strict_left_comm
 par_symmetry par_comm par_right_comm par_left_comm : par.

(*
Warning: the hint: eapply @par_strict_comm will only be used by eauto
Warning: the hint: eapply @par_strict_right_comm will only be used by eauto
Warning: the hint: eapply @par_strict_left_comm will only be used by eauto
There must be a bug because there is no reason why par_strict_comm would require to be used by eauto but not par_symmetry
*)

Ltac Par := eauto with par.

Section T12_2.

Context `{MT:Tarski_neutral_dimensionless}.
Context `{EqDec:EqDecidability Tpoint}.

Lemma Par_cases :
  forall A B C D,
  Par A B C D \/ Par B A C D \/ Par A B D C \/ Par B A D C \/
  Par C D A B \/ Par C D B A \/ Par D C A B \/ Par D C B A ->
  Par A B C D.
Proof.
    intros.
    decompose [or]  H;Par.
Qed.

Lemma Par_perm :
  forall A B C D,
  Par A B C D ->
  Par A B C D /\ Par B A C D /\ Par A B D C /\ Par B A D C /\
  Par C D A B /\ Par C D B A /\ Par D C A B /\ Par D C B A.
Proof.
    intros.
    do 7 (split; Par).
Qed.

Lemma Par_strict_cases :
  forall A B C D,
  Par_strict A B C D \/ Par_strict B A C D \/ Par_strict A B D C \/ Par_strict B A D C \/
  Par_strict C D A B \/ Par_strict C D B A \/ Par_strict D C A B \/ Par_strict D C B A ->
  Par_strict A B C D.
Proof.
    intros.
    decompose [or]  H; eauto with par.
Qed.

Lemma Par_strict_perm :
  forall A B C D,
  Par_strict A B C D ->
  Par_strict A B C D /\ Par_strict B A C D /\ Par_strict A B D C /\ Par_strict B A D C /\
  Par_strict C D A B /\ Par_strict C D B A /\ Par_strict D C A B /\ Par_strict D C B A.
Proof.
    intros.
    do 7 (split; Par).
Qed.

End T12_2.

Section T12_2'.

Context `{MT:Tarski_2D}.
Context `{EqDec:EqDecidability Tpoint}.

Lemma l12_6 : forall A B C D,
 Par_strict A B C D -> one_side A B C D.
Proof.
    intros.
    unfold Par_strict in H.
    spliter.
    assert(HH:= not_two_sides_one_side A B C D H).
    apply HH.
      intro.
      apply H2.
      exists C;Col.
      intro.
      apply H2.
      exists D;Col.
    intro.
    apply H2.
    unfold two_sides in H3.
    spliter.
    ex_and H6 T.
    exists T.
    eauto using bet_col with col.
Qed.

Lemma Perp_dec : forall A B C D, Perp A B C D \/ ~ Perp A B C D.
Proof.
    intros.
    induction (Col_dec A B C).
      induction (Perp_in_dec C A B C D).
        left.
        apply l8_14_2_1a with C;auto.
      right.
      intro.
      apply H0. clear H0.
      apply perp_in_right_comm.
      apply (l8_15_1 A B D C).
        apply perp_distinct in H1.
        intuition.
        assumption.
      apply perp_right_comm;assumption.
    elim (l8_18_existence A B C H); intros P HP.
    spliter.
    induction (eq_dec_points C D).
      subst.
      right.
      intro.
      assert (A <> B /\ D <> D) by (apply perp_distinct;assumption).
      intuition.
    induction (Col_dec P C D).
      left.
      assert (A <> B /\ C <> P) by (apply perp_distinct;assumption).
      spliter.
      apply perp_col1 with P;Col.
    right.
    intro.
    apply H3.
    apply col_permutation_2;apply perp_perp_col with A B;apply perp_sym;assumption.
Qed.

Lemma perp_perp_col_col : forall X1 X2 Y1 Y2 A B,
 Perp X1 X2 A B -> Perp Y1 Y2 A B -> Col X1 Y1 Y2 -> Col X2 Y1 Y2.
Proof.
    intros.
    assert(HH0:= H).
    assert(HH1:= H0).
    unfold Perp in HH0.
    unfold Perp in HH1.
    ex_and HH0 X0.
    ex_and HH1 Y0.
    induction(eq_dec_points X1 Y2).
      subst Y2.
      assert(Perp Y1 X1 A B).
        eapply perp_col.
          intro.
          treat_equalities.
          apply perp_distinct in H0.
          intuition.
          apply H0.
        Col.
      apply col_permutation_1.
      eapply perp_perp_col.
        apply H.
      apply perp_left_comm.
      assumption.
    assert(Perp Y2 X1 A B).
      eapply perp_col.
        auto.
        apply perp_left_comm.
        apply H0.
      Col.
    assert(Perp X1 Y2 A B).
      eapply perp_left_comm.
      assumption.
    induction(eq_dec_points X1 Y1).
      subst Y1.
      apply col_permutation_2.
      eapply perp_perp_col.
        apply H6.
      assumption.
    assert(Perp X1 Y1 A B).
      eauto using perp_left_comm, perp_col with col.
    induction (eq_dec_points X2 Y1).
      subst Y1.
      apply col_trivial_1.
    assert(Perp X2 Y1 A B).
      eauto using perp_col, perp_left_comm, perp_perp_col with col.
    (***************)
    induction (eq_dec_points X2 Y2).
      treat_equalities.
      Col.
    assert (Perp Y2 X2 A B) by (eauto using perp_col, perp_perp_col with col).
    eauto using perp_left_comm, perp_perp_col.
Qed.

Lemma l12_9 : forall A1 A2 B1 B2 C1 C2,
 coplanar A1 A2 B1 B2 -> Perp A1 A2 C1 C2 -> Perp B1 B2 C1 C2 ->
 Par A1 A2 B1 B2.
Proof.
    intros.
    unfold Par.
    unfold Par_strict.
    assert(A1 <> A2 /\ C1 <> C2) by (apply perp_distinct;assumption).
    assert(B1 <> B2 /\ C1 <> C2) by (apply perp_distinct;assumption).
    spliter.
    induction(Col_dec A1 B1 B2).
      right.
      eauto using perp_perp_col_col.
    (***********************************)
    left.
    repeat split.
      assumption.
      assumption.
      apply all_coplanar.
    intro.
    ex_and H7 AB.
    apply H6.
    induction(eq_dec_points AB A1).
      subst AB.
      assumption.
    assert(Perp A1 AB C1 C2) by (eauto using perp_col with col).
    eauto using perp_perp_col_col, perp_left_comm.
Qed.

(** We show here that from the axioms of neutral geometry we can deduce the existence of a parallel line. 
This is important because it shows that axioms of neutral geometry are inconsistent with those of elliptic geometry as 
elliptic geometry assumes that no parallel lines exist. *)
(** This corresponds to l12_10 in Tarski's book. *)

Lemma parallel_existence : forall A B P, A <> B -> exists C, exists D, C<>D /\ Par A B C D /\ Col P C D.
Proof.
    intros.
    induction(Col_dec A B P).
      exists A.
      exists B.
      repeat split.
        assumption.
        Par.
      Col.
    assert(exists P', Col A B P' /\ Perp A B P P').
      eapply l8_18_existence.
      assumption.
    ex_and H1 P'.
    assert(P <> P').
      intro.
      subst P'.
      contradiction.
    induction(eq_dec_points P' A).
      subst P'.
      assert(exists Q, Per Q P A /\ Cong Q P A B /\ one_side A P Q B).
        eapply ex_per_cong.
          auto.
          assumption.
          apply col_trivial_2.
        intro.
        apply H0.
        Col.
      ex_and H4 Q.
      exists P.
      exists Q.
      assert(P <> Q).
        intro.
        treat_equalities.
        intuition.
      repeat split.
        assumption.
        apply l12_9 with P A.
          apply all_coplanar.
          apply H2.
        apply per_perp_in in H4.
          apply perp_in_perp in H4.
          induction H4.
            apply perp_distinct in H4.
            spliter.
            absurde.
          apply perp_left_comm.
          assumption.
          auto.
        assumption.
      Col.
    assert(exists Q, Per Q P P' /\ Cong Q P A B /\ one_side P' P Q A).
      eapply ex_per_cong.
        auto.
        assumption.
        Col.
      intro.
      apply H0.
      eapply (col_transitivity_1 _ P').
        auto.
        Col.
      Col.
    ex_and H5 Q.
    exists P.
    exists Q.
    assert(P <> Q).
      intro.
      treat_equalities.
      intuition.
    repeat split.
      assumption.
      apply l12_9 with P P'.
        apply all_coplanar.
        apply H2.
      apply per_perp_in in H5.
        apply perp_in_perp in H5.
        induction H5.
          apply perp_distinct in H5.
          spliter.
          absurde.
        apply perp_left_comm.
        assumption.
        auto.
      assumption.
    Col.
Qed.

Lemma par_col_par : forall A B C D D',
 C <> D' -> Par A B C D -> Col C D D' -> Par A B C D'.
Proof.
    intros.
    unfold Par in *.
    induction H0.
      left.
      unfold Par_strict in *.
      spliter.
      repeat split.
        assumption.
        assumption.
        apply all_coplanar.
      intro.
      apply H4.
      ex_and H5 P.
      exists P.
      split.
        assumption.
      apply col_permutation_2.
      eapply col_transitivity_1.
        apply H.
        Col.
      Col.
    right.
    spliter.
    repeat split.
      assumption.
      assumption.
      apply col_permutation_2.
      eapply col_transitivity_1.
        apply H2.
        assumption.
      Col.
    apply col_permutation_2.
    eapply col_transitivity_1.
      apply H2.
      assumption.
    Col.
Qed.

Lemma parallel_existence_spec : forall A B P : Tpoint,
 A <> B -> exists C : Tpoint, C<>P /\ Par A B P C.
Proof.
    intros.
    assert (T:= parallel_existence A B P H).
    decompose [and ex] T;clear T.
    elim (eq_dec_points x P);intro.
      subst.
      exists x0.
      intuition.
    exists x.
    split.
      intuition.
    apply par_right_comm.
    apply par_col_par with x0; Par.
    Col.
Qed.

Lemma par_not_col : forall A B C D X, Par_strict A B C D -> Col X A B -> ~Col X C D.
Proof.
    intros.
    unfold Par_strict in H.
    intro.
    spliter.
    apply H4.
    exists X; Col.
Qed.

Lemma not_strict_par1 : forall A B C D X, Par A B C D -> Col A B X -> Col C D X -> Col A B C.
Proof.
    intros.
    unfold Par in H.
    induction H.
      unfold Par_strict in H.
      spliter.
      assert(exists X, Col X A B /\ Col X C D).
        exists X.
        split; Col.
      contradiction.
    spliter.
    apply col_permutation_1.
    eapply col_transitivity_1.
      apply H2.
      Col.
    Col.
Qed.

Lemma not_strict_par2 : forall A B C D X, Par A B C D -> Col A B X -> Col C D X -> Col A B D.
Proof.
    intros.
    eapply not_strict_par1.
      apply par_right_comm.
      apply H.
      apply H0.
    Col.
Qed.

Lemma not_strict_par : forall A B C D X, Par A B C D -> Col A B X -> Col C D X -> Col A B C /\ Col A B D.
Proof.
    intros.
    split.
      eapply not_strict_par1.
        apply H.
        apply H0.
      assumption.
    eapply not_strict_par2.
      apply H.
      apply H0.
    assumption.
Qed.

Lemma not_par_not_col : forall A B C, A <> B -> A <> C -> ~Par A B A C -> ~Col A B C.
Proof.
    intros.
    intro.
    apply H1.
    unfold Par.
    right.
    repeat split.
      assumption.
      assumption.
      apply col_trivial_1.
    Col.
Qed.

Lemma not_par_inter_unicity : forall A B C D X Y,
  A <> B -> C <> D -> ~Par A B C D -> Col A B X -> Col C D X -> Col A B Y -> Col C D Y ->
  X = Y.
Proof.
    intros.
    induction(eq_dec_points C Y).
      subst Y.
      induction (eq_dec_points C X).
        subst X.
        reflexivity.
      eapply inter_unicity.
        apply H2.
        apply H3.
        assumption.
        assumption.
        intro.
        apply H1.
        apply par_symmetry.
        unfold Par.
        right.
        repeat split; assumption || ColR.
(*          assumption.
          assumption.
          Col.
        assert(Col A C X) by ColR.
        assert(Col A C D) by ColR.
        apply col_permutation_2.
        ColR. 
        eapply (col_transitivity_1 _ C).
          intro.
          subst C.
          apply not_par_not_col in H1.
            apply H1.
            eapply (col_transitivity_1 _ _).
              apply H6.
              Col.
            Col.
            assumption.
          assumption.
          Col.
*)
        assumption.
  
    eapply inter_unicity.
      apply H2.
      apply H3.
      assumption.
      assumption.
      intro.
      apply H1.
      unfold Par.
      right.
      repeat split; ColR || assumption.
      assumption.
(*
     
        assert(Col A C Y).
          eapply (col_transitivity_1 _ B).
            assumption.
            Col.
          assumption.
        apply col_permutation_2.
        eapply (col_transitivity_1 _ Y).
          assumption.
          Col.
        Col.
      assert(Col B C Y).
        eapply (col_transitivity_1 _ A).
          auto.
          Col.
        Col.
      apply col_permutation_2.
      eapply (col_transitivity_1 _ Y).
        assumption.
        Col.
      Col.
    assumption. *)
Qed.

Lemma inter_unicity_not_par : forall A B C D P,
  ~Col A B C -> Col A B P -> Col C D P -> ~Par A B C D.
Proof.
    intros.
    intro.
    unfold Par in H2.
    induction H2.
      unfold Par_strict in H2.
      spliter.
      apply H5.
      exists P.
      Col5.
    spliter.
    apply H.
    ColR.
Qed.

Lemma col_not_col_not_par :
 forall A B C D,
 (exists P, Col A B P /\ Col C D P) ->
 (exists Q, Col C D Q /\ ~Col A B Q) -> ~Par A B C D.
Proof.
    intros.
    ex_and H P.
    ex_and H0 Q.
    intro.
    unfold Par in H3.
    induction H3.
      unfold Par_strict in H3.
      spliter.
      apply H6.
      exists P.
      Col5.
    spliter.
    apply H2.
    eapply col3.
      apply H4.
      Col.
      Col.
    Col.
Qed.

Lemma par_distincts : forall A B C D,
 Par A B C D -> (Par A B C D /\ A <> B /\ C <> D).
Proof.
    intros.
    split.
      assumption.
    unfold Par in H.
    induction H.
      unfold Par_strict in H.
      spliter.
      split; assumption.
    spliter.
    split; assumption.
Qed.

Lemma par_not_col_strict : forall A B C D P,
 Par A B C D -> Col C D P -> ~Col A B P -> Par_strict A B C D.
Proof.
    intros.
    apply par_symmetry in H.
    unfold Par in H.
    induction H.
      apply par_strict_symmetry.
      assumption.
    spliter.
    unfold Par_strict.
    repeat split; try assumption; try apply all_coplanar.
    intro.
    ex_and H5 X.
    apply H1.
    assert(Col A C D).
      eapply (col_transitivity_1 _ B).
        assumption.
        Col.
      Col.
    assert(Col B C D).
      eapply (col_transitivity_1 _ A).
        auto.
        Col.
      Col.
    eapply col3.
      apply H.
      Col.
      Col.
    Col.
Qed.

Lemma all_one_side_par_strict : forall A B C D,
 C <> D -> (forall P, Col C D P -> one_side A B C P) ->
 Par_strict A B C D.
Proof.
    intros.
    unfold Par_strict.
    repeat split.
      assert(HH:=H0 D (col_trivial_2 _ _)).
      unfold one_side in HH.
      ex_and HH C0.
      unfold two_sides in H1.
      spliter.
      assumption.
      assumption.
      apply all_coplanar.
    intro.
    ex_and H1 X.
    assert(HH:= H0 X (col_permutation_1 _ _ _ H2) ).
    unfold one_side in HH.
    ex_and HH M.
    unfold two_sides in H4.
    spliter.
    contradiction.
Qed.

Lemma par_col_par_2 : forall A B C D P,
 A <> P -> Col A B P -> Par A B C D -> Par A P C D.
Proof.
    intros.
    unfold Par in *.
    induction H1.
      left.
      unfold Par_strict in *.
      spliter.
      repeat split; auto; try apply all_coplanar.
      intro.
      ex_and H5 X.
      apply H4.
      exists X.
      split.
        ColR.
      Col.
    right.
    spliter.
    repeat split;auto.
    assert(Col A B D).
      ColR.
    assert(Col A B C).
      ColR.
    eapply col3.
      apply H1.
      Col.
      Col.
    Col.
Qed.


Lemma par_col2_par : forall A B C D E F,
 E <> F -> Par A B C D -> Col C D E -> Col C D F -> Par A B E F.
Proof.
    intros.
    induction (eq_dec_points C E).
      subst E.
      eapply par_col_par.
        assumption.
        apply H0.
      assumption.
    eapply par_col_par.
      assumption.
      apply par_right_comm.
      eapply par_col_par.
        apply H3.
        apply H0.
      assumption.
    apply col_permutation_2.
    eapply col_transitivity_1.
      apply par_distincts in H0.
      spliter.
      apply H5.
      assumption.
    assumption.
Qed.

Lemma par_col2_par_bis : forall A B C D E F,
 E <> F -> Par A B C D -> Col E F C -> Col E F D -> Par A B E F.
Proof.
intros.
apply par_col2_par with C D; Col; ColR.
Qed.

Lemma par_strict_col_par_strict : forall A B C D E,
 C <> E -> Par_strict A B C D -> Col C D E ->
 Par_strict A B C E.
Proof.
    intros.
    assert(Par C E A B).
      eapply par_col_par_2.
        auto.
        apply H1.
      apply par_symmetry.
      left.
      assumption.
    induction H2.
      apply par_strict_symmetry.
      assumption.
    unfold Par_strict in H0.
    spliter.
    apply False_ind.
    apply H8.
    exists C.
    split; Col.
Qed.

Lemma par_strict_col2_par_strict : forall A B C D E F,
 E <> F -> Par_strict A B C D -> Col C D E -> Col C D F ->
 Par_strict A B E F.
Proof.
    intros.
    unfold Par_strict in *.
    spliter.
    repeat split.
      assumption.
      assumption.
      apply all_coplanar.
    intro.
    apply H5.
    ex_and H6 X.
    exists X.
    split.
      assumption.
    assert(Col C E F).
      eapply col_transitivity_1.
        apply H3.
        assumption.
      assumption.
    assert(Col D E F).
      eapply (col_transitivity_1 _ C).
        auto.
        Col.
      Col.
    eapply col3.
      apply H.
      Col.
      Col.
    Col.
Qed.

Lemma line_dec : forall B1 B2 C1 C2, (Col C1 B1 B2 /\ Col C2 B1 B2) \/ ~ (Col C1 B1 B2 /\ Col C2 B1 B2).
Proof.
    intros.
    induction (Col_dec C1 B1 B2); induction (Col_dec C2 B1 B2);tauto.
Qed.

Lemma par_distinct : forall A B C D, Par A B C D -> A <> B /\ C <> D.
Proof.
    intros.
    induction H.
      unfold Par_strict in H; intuition.
    intuition.
Qed.

Definition inter A1 A2 B1 B2 X :=
 (exists P, Col P B1 B2 /\ ~Col P A1 A2) /\
 Col A1 A2 X /\ Col B1 B2 X.

Lemma inter_trivial : forall A B X, ~Col A B X -> inter A X B X X.
Proof.
    intros.
    unfold inter.
    split.
      exists B.
      split.
        Col.
      intro.
      apply H.
      Col.
    split; Col.
Qed.

Lemma inter_sym : forall A B C D X, C <> D -> inter A B C D X -> inter C D A B X.
Proof.
    intros.
    unfold inter in *.
    spliter.
    ex_and H0 P.
    assert(A <> B).
      intro.
      subst B.
      apply H3.
      Col.
    split.
      induction(eq_dec_points A X).
        treat_equalities.
        exists B.
        split.
          Col.
        intro.
        apply H3.
        eapply col3.
          apply H.
          Col.
          Col.
        Col.
      exists A.
      split.
        Col.
      intro.
      apply H3.
      assert(Col A P X).
        eapply col3.
          apply H.
          Col.
          Col.
        Col.
      ColR.
    Col.
Qed.

Lemma inter_left_comm : forall A B C D X, inter A B C D X -> inter B A C D X.
Proof.
    intros.
    unfold inter in *.
    spliter.
    ex_and H P.
    split.
      exists P.
      split.
        assumption.
      intro.
      apply H2.
      Col.
    split; Col.
Qed.

Lemma inter_right_comm : forall A B C D X, inter A B C D X -> inter A B D C X.
Proof.
    intros.
    unfold inter in *.
    spliter.
    ex_and H P.
    split.
      exists P.
      split.
        Col.
      assumption.
    split; Col.
Qed.

Lemma inter_comm : forall A B C D X, inter A B C D X -> inter B A D C X.
Proof.
    intros.
    apply inter_left_comm.
    apply inter_right_comm.
    assumption.
Qed.

Lemma other_point_exists : forall A , exists B : Tpoint, A <> B.
Proof.
    intros.
    assert(HH:=two_distinct_points).
    ex_and HH X.
    ex_and H Y.
    induction (eq_dec_points A X).
      subst A.
      exists Y.
      assumption.
    exists X.
    assumption.
Qed.

(* In the proof given by Tarski on page 125 the distinction of cases is explicit.
This will be a good example for the paper on decidability. *)
Lemma l12_17 : forall A B C D P,
 A <> B -> is_midpoint P A C -> is_midpoint P B D -> Par A B C D.
Proof.
    intros.
    induction(Col_dec A B P).
      unfold Par.
      right.
      induction(eq_dec_points A P).
        subst P.
        apply is_midpoint_id in H0.
        subst C.
        repeat split.
          assumption.
          intro.
          treat_equalities.
          apply l7_2 in H1.
          apply is_midpoint_id in H1.
          contradiction.
          apply col_trivial_1.
        unfold is_midpoint in H1.
        spliter.
        apply bet_col.
        assumption.
      induction(eq_dec_points B P).
        subst P.
        apply is_midpoint_id in H1.
        subst D.
        repeat split.
          assumption.
          intro.
          subst C.
          apply l7_2 in H0.
          apply is_midpoint_id in H0.
          auto.
          unfold is_midpoint in H0.
          spliter.
          apply bet_col in H0 .
          Col.
        apply col_trivial_3.
      assert(HH0 := H0).
      assert(HH1:= H1).
      unfold is_midpoint in H0.
      unfold is_midpoint in H1.
      spliter.
      apply bet_col in H1.
      apply bet_col in H0.
      assert(Col B C P).
        eapply col_permutation_1.
        eapply (col_transitivity_1 _ A).
          auto.
          Col.
        Col.
      assert(Col B C D).
        eapply (col_transitivity_1 _ P).
          assumption.
          Col.
        Col.
      repeat split.
        assumption.
        intro.
        treat_equalities.
        intuition.
        induction(eq_dec_points A D).
          subst D.
          apply col_trivial_3.
        assert(Col C D P).
          eapply (col_transitivity_1 _ B).
            intro.
            subst C.
            assert(A = D).
              eapply symmetric_point_unicity.
                eapply l7_2.
                apply HH0.
              assumption.
            contradiction.
            Col.
          Col.
        induction(eq_dec_points C P).
          treat_equalities.
          intuition.
        apply col_permutation_2.
        eapply (col_transitivity_1 _ P).
          assumption.
          Col.
        Col.
      assumption.
    (* cas non degenere *)
    assert(exists E, Col A B E /\ Perp A B P E).
      eapply l8_18_existence.
      assumption.
    ex_and H3 E.
    assert(A <> P).
      intro.
      treat_equalities.
      apply H2.
      apply col_trivial_3.
    induction(eq_dec_points A E).
      treat_equalities.
      assert(Per P A B).
        eapply perp_in_per.
        apply perp_in_comm.
        eapply perp_perp_in.
        apply perp_sym.
        apply perp_comm.
        assumption.
      prolong B A B' B A.
      prolong B' P D' B' P.
      assert(is_midpoint C D D').
        eapply symmetry_preserves_midpoint.
          apply H1.
          apply H0.
          split.
            apply H8.
          Cong.
        split.
          assumption.
        Cong.
      assert(Per P A B').
        eapply per_col.
          apply H.
          assumption.
        apply bet_col in H6.
        Col.
      ex_and H3 B''.
      assert(B' = B'').
        eapply symmetric_point_unicity.
          split.
            apply H6.
          Cong.
        assumption.
      subst B''.
      assert(Cong P D P D').
        apply  (cong_transitivity _ _ B P).
          unfold is_midpoint in H1.
          spliter.
          Cong.
        apply  (cong_transitivity _ _ B' P).
          Cong.
        Cong.
      assert(Per P C D).
        unfold Per.
        exists D'.
        split; assumption.
      apply per_perp_in in H14.
        apply perp_in_perp in H14.
        induction H14.
          apply perp_distinct in H14.
          intuition.
        eapply l12_9 with P A.
          apply all_coplanar.
          apply H4.
        apply perp_sym.
        eapply perp_col.
          auto.
          apply H14.
        unfold is_midpoint in H0.
        spliter.
        apply bet_col in H0.
        Col.
        intro.
        treat_equalities.
        apply l7_2 in H0.
        eapply is_midpoint_id in H0.
        auto.
      intro.
      subst D.
      assert(C = D').
        apply is_midpoint_id.
        assumption.
      subst D'.
      assert(A = B).
        eapply symmetric_point_unicity.
          apply l7_2.
          apply H0.
        apply l7_2.
        assumption.
      auto.
    prolong E P F E P.
    assert(Col C D F).
      eapply mid_preserves_col.
        2: apply H0.
        2:apply H1.
        apply H3.
      split.
        assumption.
      Cong.
    prolong A E A' A E.
    prolong A' P C' A' P.
    assert(is_midpoint F C C').
      eapply symmetry_preserves_midpoint.
        apply H0.
        split.
          apply H7.
        Cong.
        split.
          apply H12.
        Cong.
      split.
        assumption.
      Cong.
    assert(Per P E A).
      eapply perp_in_per.
      apply perp_in_comm.
      apply perp_perp_in.
      apply perp_sym.
      eapply perp_col.
        assumption.
        apply perp_right_comm.
        apply H4.
      Col.
    assert(Cong P C P C').
      eapply (cong_transitivity _ _ P A).
        unfold is_midpoint in H0.
        spliter.
        Cong.
      eapply (cong_transitivity _ _ P A').
        unfold Per in H15.
        ex_and H15 A''.
        assert( A' = A'').
          eapply symmetric_point_unicity.
            split.
              apply H10.
            Cong.
          assumption.
        subst A''.
        assumption.
      Cong.
    assert(Per P F C).
      unfold Per.
      exists C'.
      split.
        assumption.
      assumption.
    apply per_perp_in in H17.
      apply perp_in_comm in H17.
      apply perp_in_perp in H17.
      induction H17.
        apply l12_9 with P E.
          apply all_coplanar.
          apply H4.
        eapply perp_col.
          intro.
          subst D.
          assert (A = B).
            eapply symmetric_point_unicity.
              apply l7_2.
              apply H0.
            apply l7_2.
            assumption.
          auto.
          apply perp_sym.
          eapply perp_col.
            intro.
            treat_equalities.
            apply perp_distinct in H17.
            spliter.
            auto.
            apply perp_left_comm.
            apply H17.
          apply bet_col in H7.
          Col.
        Col.
      apply perp_distinct in H17.
      spliter.
      tauto.
      intro.
      treat_equalities.
      apply perp_distinct in H4.
      spliter.
      tauto.
    intro.
    subst C.
    assert(F = C').
      apply is_midpoint_id .
      assumption.
    treat_equalities.
    assert(A = E).
      eapply symmetric_point_unicity.
        apply l7_2.
        apply H0.
      split.
        apply between_symmetry.
        assumption.
      Cong.
    tauto.
Qed.

Lemma l12_18_a :
  forall A B C D P,
  Cong A B C D -> Cong B C D A -> ~Col A B C ->
  B <> D -> Col A P C -> Col B P D ->
  Par A B C D.
Proof.
    intros.
    assert(is_midpoint P A C /\ is_midpoint P B D) by (apply l7_21; assumption).
    spliter.
    eapply l12_17.
      intro.
      subst B.
      apply H1.
      apply col_trivial_1.
      apply H5.
    apply H6.
Qed.

Lemma l12_18_b :
  forall A B C D P,
  Cong A B C D -> Cong B C D A -> ~Col A B C ->
  B <> D -> Col A P C -> Col B P D ->
  Par B C D A.
Proof.
    intros.
    assert(is_midpoint P A C /\ is_midpoint P B D) by (apply l7_21; assumption).
    eapply l12_18_a.
      assumption.
      Cong.
      intro.
      apply H1.
      assert(Col B C P).
        eapply col_transitivity_1.
          apply H2.
          Col.
        Col.
      apply col_permutation_1.
      eapply (col_transitivity_1 _ P).
        intro.
        subst P.
        spliter.
        apply l7_2 in H5.
        apply is_midpoint_id in H5.
        subst C.
        apply H1.
        apply col_trivial_3.
        Col.
      Col.
      intro.
      subst C.
      apply H1.
      apply col_trivial_3.
      apply H4.
    Col.
Qed.

Lemma l12_18_c :
 forall A B C D P,
  Cong A B C D -> Cong B C D A -> ~Col A B C ->
  B <> D -> Col A P C -> Col B P D ->
  two_sides B D A C.
Proof.
    intros.
    assert(is_midpoint P A C /\ is_midpoint P B D) by (apply l7_21; assumption).
    unfold two_sides.
    repeat split.
      assumption.
      intro.
      apply H1.
      assert(Col A B P).
        apply col_permutation_2.
        eapply (col_transitivity_1 _ D).
          assumption.
          Col.
        Col.
      eapply (col_transitivity_1 _ P).
        intro.
        subst P.
        spliter.
        apply is_midpoint_id in H5.
        subst C.
        apply H1.
        apply col_trivial_3.
        Col.
      Col.
      intro.
      apply H1.
      assert(Col B P C).
        eapply (col_transitivity_1 _ D).
          assumption.
          Col.
        Col.
      apply col_permutation_1.
      eapply (col_transitivity_1 _ P).
        intro.
        subst P.
        spliter.
        apply l7_2 in H5.
        apply is_midpoint_id in H5.
        subst C.
        apply H1.
        apply col_trivial_3.
        Col.
      Col.
    exists P.
    split.
      Col.
    spliter.
    unfold is_midpoint in H5.
    tauto.
Qed.

Lemma l12_18_d :
 forall A B C D P,
 Cong A B C D -> Cong B C D A -> ~Col A B C ->
 B <> D -> Col A P C -> Col B P D ->
 two_sides A C B D.
Proof.
    intros.
    assert(is_midpoint P A C /\ is_midpoint P B D) by (apply l7_21; assumption).
    eapply (l12_18_c _ _ _ _ P).
      Cong.
      Cong.
      intro.
      apply H1.
      assert(Col A B P).
        eapply col_permutation_2.
        eapply col_transitivity_1.
          apply H2.
          Col.
        Col.
      eapply (col_transitivity_1 _ P).
        intro.
        subst P.
        spliter.
        apply is_midpoint_id in H5.
        subst C.
        contradiction.
        Col.
      Col.
      intro.
      subst C.
      apply H1.
      apply col_trivial_3.
      Col.
    Col.
Qed.

Lemma l12_18 :
 forall A B C D P,
  Cong A B C D -> Cong B C D A -> ~Col A B C ->
  B <> D -> Col A P C -> Col B P D ->
  Par A B C D /\ Par B C D A /\ two_sides B D A C /\ two_sides A C B D.
Proof.
    intros.
    split.
      apply (l12_18_a _ _ _ _ P); assumption.
    split.
      apply (l12_18_b _ _ _ _ P); assumption.
    split.
      apply (l12_18_c _ _ _ _ P); assumption.
    apply (l12_18_d _ _ _ _ P); assumption.
Qed.

Lemma par_two_sides_two_sides :
  forall A B C D,
  Par A B C D -> two_sides B D A C ->
  two_sides A C B D.
Proof.
    intros.
    apply par_distincts in H.
    spliter.
    unfold Par in H.
    induction H.
      assert(A <> C).
        intro.
        subst C.
        unfold Par_strict in H.
        spliter.
        apply H5.
        exists A.
        split; apply col_trivial_1.
      unfold two_sides in *.
      spliter.
      ex_and H6 T.
      repeat split.
        assumption.
        intro.
        assert(Col T B C).
          apply col_permutation_1.
          eapply (col_transitivity_1 _ A).
            auto.
            apply bet_col in H7.
            Col.
          Col.
        apply H5.
        apply col_permutation_2.
        eapply (col_transitivity_1 _ T).
          intro.
          treat_equalities.
          unfold Par_strict in H.
          spliter.
          apply H10.
          exists C.
          split.
            Col.
          apply col_trivial_1.
          Col.
        Col.
        intro.
        assert(Col T C D).
          apply col_permutation_2.
          apply (col_transitivity_1 _ A).
            auto.
            Col.
          apply bet_col in H7.
          Col.
        apply H5.
        apply col_permutation_1.
        apply (col_transitivity_1 _ T).
          intro.
          treat_equalities.
          unfold Par_strict in H.
          spliter.
          apply H10.
          exists A.
          split.
            apply col_trivial_1.
          Col.
          Col.
        Col.
      exists T.
      split.
        apply bet_col in H7.
        Col.
      unfold Col in H6.
      induction H6.
        assert(HH:= outer_pasch C D T A B (between_symmetry _ _ _ H7) (between_symmetry _ _ _ H6)).
        ex_and HH X.
        unfold Par_strict in H.
        spliter.
        apply False_ind.
        apply H12.
        exists X.
        apply bet_col in H8.
        apply bet_col in H9.
        split; Col.
      induction H6.
        assert(HH:= outer_pasch A B T C D H7 H6).
        ex_and HH X.
        apply False_ind.
        unfold Par_strict in H.
        spliter.
        apply H12.
        exists X.
        apply bet_col in H8.
        apply bet_col in H9.
        split; Col.
      apply between_symmetry.
      assumption.
    unfold two_sides in H0.
    spliter.
    apply False_ind.
    apply H3.
    apply col_permutation_1.
    eapply (col_transitivity_1 _ C).
      auto.
      Col.
    Col.
Qed.

Lemma out_one_side_1 :
 forall A B C D X,
 A <> B -> ~ Col A B C -> Col A B X -> out X C D ->
 one_side A B C D.
Proof.
    intros.
    induction (eq_dec_points C D).
      subst D.
      apply one_side_reflexivity.
      intro.
      apply H0.
      Col.
    prolong C X C' C X.
    exists C'.
    assert(two_sides A B C C').
      unfold two_sides.
      repeat split.
        assumption.
        intro.
        apply H0.
        Col.
        intro.
        assert(C'=X).
          eapply (inter_unicity A B C D).
            Col.
            apply out_col in H2.
            eapply (col_transitivity_1 _ X).
              intro.
              treat_equalities.
              Col5.
              Col.
            apply bet_col in H4.
            Col.
            assumption.
            apply out_col in H2.
            Col.
            intro.
            apply H0.
            Col.
          assumption.
        treat_equalities.
        unfold out in H2.
        tauto.
      exists X.
      split; Col.
    assert(two_sides A B D C').
      eapply (l9_5 _ _ _ _ X).
        apply H6.
        Col.
      assumption.
    split; assumption.
Qed.

Lemma midpoint_preserves_out :
 forall A B C A' B' C' M,
  out A B C ->
  is_midpoint M A A' ->
  is_midpoint M B B' ->
  is_midpoint M C C' ->
 out A' B' C'.
Proof.
    intros.
    unfold out in H.
    spliter.
    unfold out.
    repeat split.
      intro.
      subst B'.
      assert (A = B).
        eapply symmetric_point_unicity.
          apply l7_2.
          apply H0.
        apply l7_2.
        assumption.
      auto.
      intro.
      subst C'.
      assert (A = C).
        eapply symmetric_point_unicity.
          apply l7_2.
          apply H0.
        apply l7_2.
        assumption.
      auto.
    induction H4.
      left.
      apply (l7_15 A B C A' B' C' M); assumption.
    right.
    eapply (l7_15 A C B A' C' B' M); assumption.
Qed.


Lemma l12_21_b : forall A B C D,
 two_sides A C B D ->
 (Conga B A C D C A -> Par A B C D).
Proof.
    intros.
    apply conga_distinct in H0.
    spliter.
    assert(~Col A B C).
      intro.
      unfold two_sides in H.
      spliter.
      apply col_permutation_4 in H5.
      assert(Col D C A).
        eapply col_conga_col.
          apply H5.
        assumption.
      contradiction.
    assert(A <> B /\ C <> D).
      auto.
    spliter.
    assert(HH:=segment_construction_3 C D A B H7 H6).
    ex_and HH D'.
    assert(Conga B A C D' C A).
      eapply l11_10.
        apply H0.
        apply out_trivial.
        assumption.
        apply out_trivial.
        assumption.
        apply l6_6.
        assumption.
      apply out_trivial.
      assumption.
    assert(Cong D' A B C).
      eapply cong2_conga_cong.
        apply conga_sym.
        apply H10.
        Cong.
      Cong.
    assert(two_sides A C D' B).
      eapply l9_5.
        apply l9_2.
        apply H.
        apply col_trivial_3.
      assumption.
    unfold two_sides in H12.
    spliter.
    ex_and H15 M.
    assert(B <> D').
      intro.
      treat_equalities.
      contradiction.
    assert(is_midpoint M A C /\ is_midpoint M B D').
      apply l7_21.
        assumption.
        assumption.
        Cong.
        Cong.
        Col.
      apply bet_col in H16.
      Col.
    spliter.
    assert(Par A B C D').
      eapply l12_17.
        assumption.
        apply H18.
      assumption.
    eapply par_col_par.
      auto.
      apply H20.
    apply out_col in H8.
    Col.
Qed.

Lemma l6_7_1 : forall A B C D,
 out A B C -> out A B D ->
 out A C D.
Proof.
    intros.
    unfold out in *.
    spliter.
    repeat split;try assumption.
    intuition; eauto using l5_1, l5_3, between_exchange4.
Qed.

Lemma l12_22_aux :
 forall A B C D P,
  Distincts P A C -> Bet P A C -> one_side P A B D ->
  Conga B A P D C P ->
  Par A B C D.
Proof.
    intros.
    prolong B A B' B A .
    unfold Distincts in H.
    spliter.
    assert(Conga P A B C A B').
      apply l11_14.
        assumption.
        repeat split; auto.
        assumption.
      repeat split.
        unfold Conga in H2.
        tauto.
        intro.
        treat_equalities.
        unfold Conga in H2.
        tauto.
      intro.
      treat_equalities.
      unfold Conga in H2.
      tauto.
    assert(Conga D C A D C P).
      eapply l11_10.
        apply conga_refl.
          3: apply out_trivial.
          unfold Conga in H2.
          tauto.
        5:apply out_trivial.
        auto.
        unfold Conga in  H2.
        tauto.
        apply between_symmetry in H0.
        apply bet_out in H0.
          assumption.
          auto.
        auto.
        apply out_trivial.
        unfold Conga in H2.
        tauto.
      auto.
    assert(Par A B' C D).
      eapply l12_21_b.
        assert(~Col B P A).
          unfold one_side in H1.
          ex_and H1 T.
          unfold two_sides in H1.
          tauto.
        assert(two_sides P A B B').
          unfold two_sides.
          repeat split.
            auto.
            assumption.
            intro.
            apply H9.
            apply col_permutation_1.
            eapply (col_transitivity_1 _ B').
              intro.
              treat_equalities.
              unfold Conga in H2.
              tauto.
              apply bet_col in H3.
              Col.
            Col.
          exists A.
          split.
            Col.
          assumption.
        apply l9_2.
        eapply l9_8_2.
          eapply col_two_sides.
            3:apply invert_two_sides.
            3: apply H10.
            apply bet_col in H0.
            Col.
          assumption.
        eapply col_one_side.
          3: apply invert_one_side.
          3: apply H1.
          apply bet_col in H0.
          Col.
        assumption.
      eapply conga_trans.
        apply conga_sym.
        apply conga_comm.
        apply H7.
      eapply conga_trans.
        apply H2.
      apply conga_sym.
      assumption.
    apply par_symmetry.
    eapply par_col_par.
      2: apply par_symmetry.
      2:apply H9.
      unfold Conga in H2.
      spliter.
      auto.
    apply bet_col in H3.
    Col.
Qed.


Lemma l12_22_b :
 forall A B C D P,
  out P A C -> one_side P A B D -> Conga B A P D C P ->
  Par A B C D.
Proof.
    intros.
    induction(eq_dec_points A C).
      subst C.
      unfold Par.
      right.
      repeat split.
        unfold Conga in H1.
        spliter.
        auto.
        unfold Conga in H1.
        spliter.
        auto.
        Col.
      apply conga_comm in H1.
      apply l11_22_aux in H1.
      induction H1.
        apply out_col in H1.
        Col.
      apply l9_9 in H1.
      contradiction.
    unfold out in H.
    spliter.
    induction H4.
      eapply l12_22_aux.
        2:apply H4.
        repeat split; auto.
        assumption.
      assumption.
    apply par_symmetry.
    eapply l12_22_aux.
      2:apply H4.
      repeat split; auto.
      eapply (col_one_side _ A).
        apply bet_col in H4.
        Col.
        auto.
      apply one_side_symmetry.
      assumption.
    apply conga_sym.
    assumption.
Qed.

Lemma par_strict_par : forall A B C D,
 Par_strict A B C D -> Par A B C D.
Proof.
    intros.
    unfold Par.
    tauto.
Qed.


Lemma par_strict_distinct : forall A B C D,
 Par_strict A B C D -> A<>B /\ C<>D.
Proof.
    intros.
    apply par_strict_par in H.
    apply par_distincts.
    assumption.
Qed.

Lemma col_par : forall A B C,
 A <> B -> B <> C ->
 Col A B C -> Par A B B C.
Proof.
    intros.
    unfold Par.
    right.
    intuition Col.
Qed.

End T12_2'.

Hint Resolve col_par : par.

Ltac finish := repeat match goal with
 | |- Bet ?A ?B ?C => Between
 | |- Col ?A ?B ?C => Col
 | |- ~ Col ?A ?B ?C => Col
 | |- Par ?A ?B ?C ?D => Par
 | |- Par_strict ?A ?B ?C ?D => Par
 | |- Perp ?A ?B ?C ?D => Perp
 | |- Perp_in ?A ?B ?C ?D ?E => Perp
 | |- Per ?A ?B ?C => Perp
 | |- Cong ?A ?B ?C ?D => Cong
 | |- is_midpoint ?A ?B ?C => Midpoint
 | |- ?A<>?B => apply swap_diff;assumption
 | |- _ => try assumption
end.

Section T12_3.

Context `{MT:Tarski_neutral_dimensionless}.
Context `{EqDec:EqDecidability Tpoint}.

Lemma perp_not_par : forall A B X Y, Perp A B X Y -> ~ Par A B X Y.
Proof.
    intros.
    assert(HH:=H).
    unfold Perp in HH.
    ex_and HH P.
    intro.
    induction H1.
      apply H1.
      exists P.
      apply perp_in_col in H0.
      spliter.
      split; Col.
    spliter.
    induction(eq_dec_points A Y).
      subst Y.
      assert(P = A).
        eapply (l8_14_2_1b P A B X A); Col.
      subst P.
      apply perp_in_comm in H0.
      apply perp_in_per in H0.
      assert(~ Col B A X).
        eapply(per_not_col).
          auto.
          auto.
        assumption.
      apply H5.
      Col.
    apply(l8_16_1 A B X A Y); Col.
      ColR.
    ColR.
Qed.

Lemma cong_conga_perp : forall A B C P, two_sides B P A C -> Cong A B C B -> Conga A B P C B P -> Perp A C B P.
Proof.
    intros.
    assert(HH:=H).
    unfold two_sides in HH.
    spliter.
    ex_and H5 T.
    assert(B <> P).
      intro.
      subst P.
      apply H3.
      Col.
    assert(A <> B).
      intro.
      subst B.
      apply H3.
      Col.
    assert(C <> B).
      intro.
      subst C.
      apply H4.
      Col.
    assert(A <> C).
      intro.
      subst C.
      assert(one_side B P A A).
        apply one_side_reflexivity.
        assumption.
      apply l9_9 in H.
      contradiction.
    induction (Bet_dec A B C).
      assert(Per P B A).
        apply(l11_18_2 P B A C); auto.
          repeat split; auto.
        apply conga_comm.
        assumption.
      eapply (col_per_perp _ _ _ C) in H12; auto.
        apply perp_right_comm.
        assumption.
      apply bet_col in H11.
      Col.
    assert(B <> T).
      intro.
      subst T.
      contradiction.
    assert(Conga T B A T B C).
      induction H5.
        eapply (l11_13 P _ _ P); Between.
        apply conga_comm.
        apply H1.
      assert(out B P T).
        repeat split; auto.
        induction H5.
          left.
          Between.
        right.
        Between.
      apply conga_comm.
      eapply (out_conga A _ P C _ P); auto.
        apply out_trivial.
        auto.
      apply out_trivial.
      auto.
    assert(Cong T A T C).
      apply (cong2_conga_cong T B A T B C); Cong.
    assert(is_midpoint T A C).
      split; Cong.
    assert(Per B T A).
      unfold Per.
      exists C.
      split; Cong.
    eapply (col_per_perp _ _ _ C) in H16; auto.
      apply perp_sym.
      apply (perp_col _ T); Col.
      Perp.
      intro.
      subst T.
      apply is_midpoint_id in H15.
      contradiction.
      intro.
      subst T.
      apply l7_2 in H15.
      apply is_midpoint_id in H15.
      apply H10.
      auto.
    apply bet_col in H6.
    Col.
Qed.

End T12_3.