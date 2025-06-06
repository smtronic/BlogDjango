from django.shortcuts import redirect
from django.urls import reverse


def handle_social_auth_error(strategy, backend, response, *args, **kwargs):
    if response.status_code != 200:
        error_message = "Ошибка при авторизации через социальную сеть."
        return redirect(reverse("social_auth_error") + f"?error={error_message}")
    return None
