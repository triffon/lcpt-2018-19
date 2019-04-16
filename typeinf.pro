/*
zero
succ(zero)
mult(succ(zero), two)

equal(succ(zero), two).
types(Γ, M, τ).
*/

:- set_prolog_flag(occurs_check, true).

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
2. app(M, N).
3. λ(x, N).

Типове
1. α
2. arrow(Ρ, Σ).

Типови съждения
is(M, Τ).

Списъци
1. []
2. [X | T]

Контекст = списък от типови съждения (с условие)

types(Γ, M, Τ).
*/

i(λ(x, x)).
k(λ(x, λ(y, x))).
kstar(λ(x, λ(y, y))).
s(λ(x, λ(y, λ(z, app(app(x,z),app(y,z)))))).
omega(λ(x, app(x,x))).

% types(+Γ, +M, -Τ).

types(Γ, X, Τ) :- member(is(X, Τ), Γ).
types(Γ, app(M1, M2), Σ) :-
    types(Γ, M1, arrow(Ρ, Σ)),
    types(Γ, M2, Ρ).
types(Γ, λ(X, N), arrow(Ρ, Σ)) :-
    types([ is(X, Ρ) | Γ ], N, Σ).

types(M, Τ) :- types([], M, Τ).
