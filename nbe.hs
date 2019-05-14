data Lambda = Var Int |
              App Lambda Lambda |
              Λ Lambda
              deriving Show

k = Λ (Λ (Var 1))
s = Λ (Λ (Λ (App
              (App (Var 2) (Var 0))
              (App (Var 1) (Var 0)))))

c n = Λ (Λ
          (iterate (App (Var 1))
            (Var 0) !! n))

ctype = Arrow itype itype

cplus = Λ (Λ (Λ (Λ (App (App (Var 3)
                         (Var 1))
                    (App (App (Var 2)
                          (Var 1))
                     (Var 0))))))

type Syn = Int -> Lambda

data Sem = Base Syn | Fun (Sem -> Sem)

type Valuation = [Sem]

data Type = Mu | Arrow Type Type

itype = Arrow Mu Mu

modify ξ a = a : ξ

evaluate :: Lambda -> Valuation -> Sem
evaluate (Var i) ξ     = ξ !! i   -- ξ(i)
evaluate (App m₁ m₂) ξ =
  f (evaluate m₂ ξ)
  where Fun f = evaluate m₁ ξ
evaluate (Λ n) ξ =
  Fun (\a -> evaluate n (modify ξ a))


x :: Int -> Syn
x k l = Var (l - k)


app :: Syn -> Syn -> Syn
app m₁ m₂ k = App (m₁ k) (m₂ k)

(⇑) :: Type -> Syn -> Sem
Mu          ⇑ m = Base m
(Arrow ρ σ) ⇑ m =
  Fun (\a -> σ ⇑ (app m (ρ ⇓ a)))

(⇓) :: Type -> Sem -> Syn
Mu          ⇓ (Base m) = m
(Arrow ρ σ) ⇓ (Fun f)  =
  \n -> Λ ((σ ⇓ (f (ρ ⇑ x (n+1)))) (n+1))

-- ще нормализираме само затворени термове

nbe :: Type -> Lambda -> Lambda
nbe τ m = (τ ⇓ (evaluate m [])) 0

i = nbe itype (App (App s k) k)

c8 = nbe ctype (App (App cplus (c 3))
                 (c 5))
