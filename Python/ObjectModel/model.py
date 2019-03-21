# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    model.py                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Zexi Wang <twopieces0921@gmail.com>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/21 18:43:25 by Zexi Wang         #+#    #+#              #
#    Updated: 2019/02/25 23:01:26 by Zexi Wang        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

class Base(object):
	""" The base class that all of the object model classes inherit from. """

	def __init__(self, cls, fields):
		self.cls = cls
		self._fields = fields

	def read_attr(self, fieldname):
		result = self._read_dict(fieldname)
		if result is not MISSING:
			return result
		reuslt = self.cls._read_from_class(fieldname)
		if _is_bindable(result):
			return _make_boundmethod(result, self)
		if result is not MISSING:
			return result
		raise AttributeError(fieldname)
	
	def write_attr(self, fieldname, value):
		self._write_dict(fieldname, value)
	
	def isinstance(self, cls):
		return self.cls.issubclass(cls)

	def callmethod(self, methname, *args):
		meth = self.read_attr(methname)
		return meth(*args)

	def _read_dict(self, fieldname):
		return self._fields.get(fieldname, MISSING)
	
	def _write_dict(self, fieldname, value):
		self._fields[fieldname] = value

MISSING = object()


class Instance(Base):
	""" Instance of a user-defined class."""

	def __init__(self, cls):
		assert isinstance(cls, Class)
		Base.__init__(self, cls, {})


class Class(Base):
	""" A user-defined class."""

	def __init__(self, name, base_class, fields, metaclass):
		Base.__init__(self, metaclass, fields)
		self.name = name
		self.base_class = base_class
	
	def method_resolution_order(self):
		if self.base_class is None:
			return [self]
		else:
			return [self] + self.base_class.method_resolution_order()
	
	def issubclass(self, cls):
		return cls in self.method_resolution_order()

	def _read_from_class(self, methname):
		for cls in self.method_resolution_order():
			if methname in cls._fields:
				return cls._fields[methname]
		return MISSING


# The ultimate base class is OBJECT
OBJECT = Class(name="object", base_class=None, fields={}, metaclass=None)
# TYPE is a subclass of OBJECT
TYPE = Class(name="type", base_class=OBJECT, fields={}, metaclass=None)
# TYPE is an instance of itself
TYPE.cls = TYPE
# OBJECT is an instance of TYPE
OBJECT.cls = TYPE


def _is_bindable(meth):
	return callable(meth)


def _make_boundmethod(meth, self):
	def bound(*args):
		return meth(self, *args)
	return bound
