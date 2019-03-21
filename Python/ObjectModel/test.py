# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test.py                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Zexi Wang <twopieces0921@gmail.com>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/21 18:14:07 by Zexi Wang         #+#    #+#              #
#    Updated: 2019/02/25 23:55:50 by Zexi Wang        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

from model import Base, Class, Instance, OBJECT, TYPE

def test_read_write_field():
	# Python code
	class A(object):
		pass
	obj = A()
	obj.a = 1
	assert obj.a == 1

	obj.b = 5
	assert obj.a == 1
	assert obj.b == 5

	obj.a = 2
	assert obj.a == 2
	assert obj.b == 5

	#Object model code
	A = Class(name="A", base_class=OBJECT, fields={}, metaclass=TYPE)
	obj = Instance(A)
	obj.write_attr("a", 1)
	assert obj.read_attr("a") == 1

	obj.write_attr("b", 5)
	assert obj.read_attr("a") == 1
	assert obj.read_attr("b") == 5

	obj.write_attr("a", 2)
	assert obj.read_attr("a") == 2
	assert obj.read_attr("b") == 5


def test_read_write_field_class():
	# Classes are objects too.
	# Python code
	class A(object):
		pass
	A.a = 1
	assert A.a == 1
	A.a = 6
	assert A.a == 6

	# Object model code
	A = Class(name="A", base_class=OBJECT, fields={"a": 1}, metaclass=TYPE)
	assert A.read_attr("a") == 1
	A.write_attr("a", 5)
	assert A.read_attr("a") == 5


def test_isinstance():
	# Python code
	class A(object):
		pass
	class B(A):
		pass
	b = B()
	assert isinstance(b, B)
	assert isinstance(b, A)
	assert isinstance(b, object)
	assert not isinstance(b, type)

	# Object model code
	A = Class(name="A", base_class=OBJECT, fields={}, metaclass=TYPE)
	B = Class(name="B", base_class=A, fields={}, metaclass=TYPE)
	b = Instance(B)
	assert b.isinstance(B)
	assert b.isinstance(A)
	assert b.isinstance(OBJECT)
	assert not b.isinstance(TYPE)


def test_callmethod_simple():
	# Python code
	class A(object):
		def f(self):
			return self.x + 1
	obj = A()
	obj.x = 1
	assert obj.f() == 2

	class B(A):
		pass
	obj = B()
	obj.x = 1
	assert obj.f() == 2

	# Object model code
	def f_A(self):
		return self.read_attr("x") + 1
	A = Class(name="A", base_class=OBJECT, fields={"f": f_A}, metaclass=TYPE)
	obj = Instance(A)
	obj.write_attr("x", 1)
	assert obj.callmethod("f") == 2

	B = Class(name="A", base_class=OBJECT, fields={"f": f_A}, metaclass=TYPE)
	obj = Instance(B)
	obj.write_attr("x", 2)
	assert obj.callmethod("f") == 3


def test_callmethod_subclassing_and_arguments():
	# Python code
	class A(object):
		def g(self, arg):
			return self.x + arg
	obj = A()
	obj.x = 1
	assert obj.g(4) == 5

	class B(A):
		def g(self, arg):
			return self.x + arg * 2
	obj = B()
	obj.x = 4
	assert obj.g(4) == 12

	# Object model code
	def g_A(self, arg):
		return self.read_attr("x") + arg
	A = Class(name="A", base_class=OBJECT, fields={"g": g_A},
			  metaclass=TYPE)
	obj = Instance(A)
	obj.write_attr("x", 1)
	assert obj.callmethod("g", 4) == 5

	def g_B(self, arg):
		return self.read_attr("x") + arg * 2
	B = Class(name="B", base_class=A, fields={"g": g_B}, metaclass=TYPE)
	obj = Instance(B)
	obj.write_attr("x", 4)
	assert obj.callmethod("g", 4) == 12


def test_bound_method():
	# Python code
	class A(object):
		def f(self, a):
			return self.x + a + 1
	obj = A()
	obj.x = 2
	m = obj.f
	assert m(4) == 7

	class B(A):
		pass
	obj = B()
	obj.x = 1
	m = obj.f
	assert m(10) == 12

	# Object model code
	def f_A(self, a):
		return self.read_attr("x") + a + 1
	A = Class(name="A", base_class=OBJECT, fields={"f": f_A}, metaclass=TYPE)
	obj = Instance(A)
	obj.write_attr("x", 2)
	m = obj.read_attr("f")
	assert m(4) == 7

	B = Class(name="B", base_class=A, fields={}, metaclass=TYPE)
	obj = Instance(B)
	obj.write_attr("x", 1)
	m = obj.read_attr("f")
	assert m(10) == 12


def test_getattr():
	# Python code
	class A(object):
		def __getattr__(self, name):
			if name == "fahrenheit":
				return self.celsius * 9. / 5. + 32
			raise AttributeError(name)

		def __setattr__(self, name, value):
			if name == "fahrenheit":
				self.celsius = (value - 32) * 5. / 9.
			else
				object.__setattr__(self, name, value)
	obj = A()
	obj.celsius = 30
	assert obj.fahrenheit == 86
	obj.celsius = 40
	assert obj.fahrenheit == 104

	obj.fahrenheit = 86
	assert obj.celsius = 30
	assert obj.fahrenheit == 86

	# Object model code
	def __getattr__(self, name):
		if name == "fahrenheit":
			return self.read_attr("celsius") * 9. / 5. + 32
		raise AttributeError(name)
	def __setattr__(self, name, value):
		if name == "fahrenheit":
			self.write_attr("celsius", (value - 32) * 5. / 9.
		else:
			OBJECT.read_attr("__setattr__")(self, name, value)




if __name__ == "__main__":
	test_read_write_field()
	test_read_write_field_class()
	test_isinstance()
	test_callmethod_simple()
	test_callmethod_subclassing_and_arguments()
