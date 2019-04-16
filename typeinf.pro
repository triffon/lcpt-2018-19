/*
zero
succ(zero)
mult(succ(zero), two)

equal(succ(zero), two).
types(Γ, M, τ).
*/

:- set_prolog_flag(occurs_check, true).
/*
:- op(+priority, +ariry_assoc, +symbol).
*/
:- op(160, fx, ⊢).
:- op(150, xfx, ⊢).
:- op(140, xfx, :).
:- op(120, xfy, ⇒).
:- op(100, yfx, @).

man(john).
man(ted).

woman(mary).

loves(john, wine).
loves(mary, wine).
loves(john, X) :- loves(X, wine).

add(zero, X, X).
add(succ(X), Y, succ(Z)) :- add(X, Y, Z).

/*
Термове
1. x
2. M @ N
3. λ(x, N)

Типове
1. α
2. Ρ ⇒ Σ

Типови съждения
M : Τ.

Списъци
1. []
2. [X | T]

Контекст = списък от типови съждения (с условие)

Γ ⊢ M : Τ.
*/

i(λ(x, x)).
k(λ(x, λ(y, x))).
kstar(λ(x, λ(y, y))).
s(λ(x, λ(y, λ(z, x@z@(y@z))))).
omega(λ(x, x@x)).

% types(+Γ, +M, -Τ).

Γ ⊢ X : Τ           :-      member(X : Τ, Γ).
Γ ⊢ M1 @ M2 : Σ     :-      Γ ⊢ M1 : Ρ ⇒ Σ, Γ ⊢ M2 : Ρ. 
Γ ⊢ λ(X, N) : Ρ ⇒ Σ :-      not(member(X : _, Γ)), [ X : Ρ | Γ ] ⊢ N : Σ.
⊢ M : Τ             :-      [] ⊢ M : Τ.
