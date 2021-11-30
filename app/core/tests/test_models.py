from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTEsts(TestCase):

    def tests_create_user_with_email_successful(self):
        # Test creating a new user with an email is successful.
        email = 'kimsTest@gmail.com'
        password = 'Testpass123'
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def tests_new_user_email_normalized(self):
        # Test the email for a new user is normalized.
        email = 'kimstest@Gmail.com'
        password = 'Testpass123'
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )
        self.assertEqual(user.email, email.lower())

    def tests_new_user_invalid_email(self):
        # Test creating a user with no email raises error.
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, 'test123')

    def test_new_superuser_is_created_successfully(self):
        # Test creating a new superuser.
        user = get_user_model().objects.create_superuser(
            email='kimsSuperUser@gmail.com',
            password='Testpass12345'
        )
        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
