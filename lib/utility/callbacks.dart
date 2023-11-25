/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
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
