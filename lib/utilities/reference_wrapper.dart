part of 'utilities.dart';

class ReferenceWrapper<T> {
  ReferenceWrapper(this.wrapped);

  T wrapped;
  T getInstance() => wrapped;
  void setInstance(T newWrapped) => wrapped = newWrapped;
}