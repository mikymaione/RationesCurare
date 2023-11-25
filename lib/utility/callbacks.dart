typedef VoidCallback = void Function();
typedef Void0ParamCallbackFuture = Future<void> Function();
typedef Void1ParamCallbackFuture<A> = Future<void> Function(A a);
typedef Void2ParamCallbackFuture<A, B> = Future<void> Function(A a, B b);

typedef Void0ParamCallback = void Function();
typedef Void1ParamCallback<A> = void Function(A a);
typedef Void2ParamCallback<C, D> = void Function(C c, D d);
typedef Void3ParamCallback<J, K, L> = void Function(J j, K k, L l);

typedef Generic0ParamCallback<B> = B Function();
typedef Generic0ParamCallbackFuture<B> = Future<B> Function();
typedef Generic1ParamCallback<J, R> = R Function(J j);
typedef Generic1ParamCallbackFuture<J, R> = Future<R> Function(J j);
typedef Generic2ParamCallback<J, O, R> = R Function(J j, O o);
