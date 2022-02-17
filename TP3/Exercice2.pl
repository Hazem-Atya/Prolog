fibonacci(0,RES):-RES is 1.
fibonacci(1,RES):-RES is 1.
fibonacci(N,RES):-N1 is N-1,N2 is N-2, fibonacci(N1,RES1),fibonacci(N2,RES2),RES is RES1+RES2.
