from django.test import TestCase
from .views import dziel


class TestDzielenie(TestCase):

    def test_normal(self):
        c = dziel(10, 2)
        self.assertEqual(c, 5)

    def test_0(self):
        c = dziel(10, 0)
        self.assertEqual(c, None)


