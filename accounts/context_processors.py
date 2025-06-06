from decouple import config


def social_backends(request):
    return {
        "google_oauth_enabled": config("SOCIAL_AUTH_GOOGLE_OAUTH2_KEY", default=None)
        and config("SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET", default=None),
        "vk_oauth_enabled": config("SOCIAL_AUTH_VK_OAUTH2_KEY", default=None)
        and config("SOCIAL_AUTH_VK_OAUTH2_SECRET", default=None),
    }
