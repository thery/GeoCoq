Require Export quadrilaterals_inter_dec.

Ltac assert_all := treat_equalities; assert_cols_perm; assert_diffs; assert_congs_perm.

Section TriangleMidpointsTheorems.

Context `{MT:Tarski_2D_euclidean}.
Context `{EqDec:EqDecidability Tpoint}.

Lemma triangle_mid_par_strict_cong_aux : forall A B C P Q R,
 ~Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par_strict A B Q P  /\ Cong A R P Q /\ Cong B R P Q .
Proof with finish.
intros.
Name x the symmetric of P wrt Q.
assert_all.
assert (~ Col A P C) by (intro; search_contradiction).
assert_diffs.
assert (Parallelogram_strict A P C x) by (apply mid_plgs with Q;finish).
assert_all.
assert_paras_perm.
assert_pars_perm.
assert (Cong A x B P) by eCong.
assert (Par A x B P) by (apply par_col2_par with P C; finish).
assert (HElim : Parallelogram A x B P \/ Parallelogram A x P B) by (apply par_cong_plg_2; assumption).

induction HElim.

 Name M the intersection of the diagonals (A B) and (x P) of the parallelogram H28.
 treat_equalities.
 search_contradiction.

assert_paras_perm.
assert_pars_perm.
assert (Par P Q A B) by (apply par_col_par_2 with x; finish).
split.

apply par_not_col_strict with x...
 intro.
 assert_cols_perm.
 apply H.
 ColR.

assert_congs_perm;split;eCong.
Qed.

Lemma triangle_par_mid : forall A B C P Q,
 ~Col A B C ->
 is_midpoint P B C ->
 Par A B Q P ->
 Col Q A C ->
 is_midpoint Q A C.
Proof.
assert (H:=playfair_s_postulate_implies_midpoints_converse_postulate);
unfold midpoints_converse_postulate in H; intros; apply H with B P; Col.
unfold playfair_s_postulate.
apply parallel_unicity.
Qed.

Lemma triangle_mid_par_strict_cong_1 : forall A B C P Q R,
 ~Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par_strict A B Q P  /\ Cong A R P Q.
Proof.
intros.
assert (Par_strict A B Q P /\ Cong A R P Q /\ Cong B R P Q)
  by (apply triangle_mid_par_strict_cong_aux with C; assumption).
spliter.
split; assumption.
Qed.

Lemma triangle_mid_par_strict_cong_2 : forall A B C P Q R,
 ~Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par_strict A B Q P  /\ Cong B R P Q.
Proof.
intros.
assert (Par_strict A B Q P /\ Cong A R P Q /\ Cong B R P Q)
  by (apply triangle_mid_par_strict_cong_aux with C; assumption).
spliter.
split; assumption.
Qed.

Lemma triangle_mid_par_strict_cong_simp : 
 forall A B C P Q,
 ~ Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 Par_strict A B Q P.
Proof.
apply triangle_mid_par.
Qed.

Lemma triangle_mid_par_strict_cong : forall A B C P Q R,
 ~Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par_strict A B Q P /\ Par_strict A C P R /\ Par_strict B C Q R /\
 Cong A R P Q /\ Cong B R P Q /\ Cong A Q P R /\ Cong C Q P R /\ Cong B P Q R /\ Cong C P Q R.
Proof with finish.
intros.
permutation_intro_in_hyps.
assert (Par_strict A B Q P /\ Cong A R P Q /\ Cong B R P Q)
  by (apply triangle_mid_par_strict_cong_aux with C; assumption).
assert (Par_strict A C R P /\ Cong A Q P R /\ Cong C Q P R)
  by (apply triangle_mid_par_strict_cong_aux with B; Col).
assert (Par_strict C B Q R /\ Cong C P R Q /\ Cong B P R Q)
  by (apply triangle_mid_par_strict_cong_aux with A; Col).
spliter.

split...
split...
split...
repeat split...
Qed.

Lemma triangle_mid_par_strict : forall A B C P Q,
 ~Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 Par_strict A B Q P.
Proof with finish.
intros.
Name R the midpoint of A and B.
assert (HTMT := triangle_mid_par_strict_cong A B C P Q R H H0 H1 H3); spliter.
assumption. 
Qed.

Lemma triangle_mid_par_flat_cong_aux : forall A B C P Q R,
 B <> A ->
 Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par A B Q P /\ Cong A R P Q /\ Cong B R P Q.
Proof with finish.
intros.

elim (eq_dec_points A C); intro.

  assert_all.
  split; try Cong.
  perm_apply (col_par)...

elim (eq_dec_points B C); intro.
  assert_all.
  split; try Cong.
  perm_apply (col_par)...

elim (eq_dec_points A P); intro.
  assert_all.
  assert (Col A B Q) by ColR.
  split.
  perm_apply (col_par).
  assert_congs_perm.
  split; eCong.

Name x the symmetric of P wrt Q. 

elim (eq_dec_points P x); intro.
  treat_equalities; intuition.

assert_cols.
assert (Parallelogram A P C x) by (apply mid_plg_1 with Q;finish).
assert_all.
assert_pars_perm.
assert (Cong A x B P) by eCong.
assert (Par A x B P) by (apply par_col2_par with P C; finish).

assert (HElim : Parallelogram A x B P \/ Parallelogram A x P B) by (apply par_cong_plg_2; assumption).

induction HElim.

 Name M the intersection of the diagonals (A B) and (x P) of the parallelogram H19.
 treat_equalities.
 search_contradiction.

 assert_paras_perm.
 assert_pars_perm.
 assert (Par P Q A B) by (apply par_col_par_2 with x; finish).
 assert_congs_perm.
 repeat split; try eCong...
Qed.

Lemma triangle_mid_par_flat_cong_1 : forall A B C P Q R,
 B <> A ->
 Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par A B Q P  /\ Cong A R P Q.
Proof.
intros.
assert (Par A B Q P /\ Cong A R P Q /\ Cong B R P Q)
  by (apply triangle_mid_par_flat_cong_aux with C; assumption).
spliter.
split; assumption.
Qed.

Lemma triangle_mid_par_flat_cong_2 : forall A B C P Q R,
 B <> A ->
 Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par A B Q P  /\ Cong B R P Q.
Proof.
intros.
assert (Par A B Q P /\ Cong A R P Q /\ Cong B R P Q)
  by (apply triangle_mid_par_flat_cong_aux with C; assumption).
spliter.
split; assumption.
Qed.

Lemma triangle_mid_par_flat_cong : forall A B C P Q R,
 B <> A ->
 C <> A ->
 C <> B ->
 Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par A B Q P /\ Par A C P R /\ Par B C Q R /\
 Cong A R P Q /\ Cong B R P Q /\ Cong A Q P R /\ Cong C Q P R /\ Cong B P Q R /\ Cong C P Q R.
Proof with finish.
intros.
permutation_intro_in_hyps.
assert (Par A B Q P /\ Cong A R P Q /\ Cong B R P Q) by (apply triangle_mid_par_flat_cong_aux with C; assumption).
assert (Par A C R P /\ Cong A Q P R /\ Cong C Q P R) by (apply triangle_mid_par_flat_cong_aux with B; Col).
assert (Par C B Q R /\ Cong C P R Q /\ Cong B P R Q) by (apply triangle_mid_par_flat_cong_aux with A; Col).
spliter.

repeat split...
Qed.

Lemma triangle_mid_par_flat : forall A B C P Q,
 B <> A ->
 Col A B C ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 Par A B Q P.
Proof.
intros.
elim (midpoint_existence A B); intro R; intro.
assert (HTMT := triangle_mid_par_flat_cong_aux A B C P Q R H H0 H1 H2 H3); spliter.
assumption.
Qed.

Lemma triangle_mid_par : forall A B C P Q,
 A <> B ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 Par A B Q P.
Proof.
intros.

elim (Col_dec A B C); intro.
  apply triangle_mid_par_flat with C; finish.

  apply par_strict_par; apply triangle_mid_par_strict with C; assumption.
Qed.

Lemma triangle_mid_par_cong : forall A B C P Q R,
 B <> A ->
 C <> A ->
 C <> B ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par A B Q P /\ Par A C P R /\ Par B C Q R /\
 Cong A R P Q /\ Cong B R P Q /\ Cong A Q P R /\ Cong C Q P R /\ Cong B P Q R /\ Cong C P Q R.
Proof.
intros.

elim (Col_dec A B C); intro.
  apply triangle_mid_par_flat_cong; assumption.

  assert (HTMT := triangle_mid_par_strict_cong A B C P Q R H5 H2 H3 H4); spliter.
  repeat split; try apply par_strict_par; assumption.
Qed.


Lemma triangle_mid_par_cong_1 : forall A B C P Q R,
 C <> B ->
 is_midpoint P B C ->
 is_midpoint Q A C ->
 is_midpoint R A B ->
 Par B C Q R /\ Cong B P Q R .
Proof.
intros.
split.
perm_apply (triangle_mid_par B C A Q R);finish.
induction (Col_dec A B C).
 assert (Par C B Q R /\ Cong B P R Q).
  apply (triangle_mid_par_flat_cong_2 C B A R Q P);finish.
  spliter.
  finish.
 assert (HTMT := triangle_mid_par_strict_cong A B C P Q R H3 H0 H1 H2); spliter.
 finish.
Qed.

End TriangleMidpointsTheorems.