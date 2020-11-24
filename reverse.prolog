r([], []).
r([HeadLeft|TailLeft], Reversed) :- 
    last(Reversed, LastElementOfReverse),
    LastElementOfReverse = HeadLeft,
    except_last(Reversed, LastRemoved),
    r(TailLeft, LastRemoved).

except_last([_], []).
except_last([A|B], [C|D]) :- A = C, except_last(B, D).
