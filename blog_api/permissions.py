from rest_framework import permissions
from rest_framework.request import Request


class IsAuthorReadOrOnly(permissions.BasePermission):
    def has_permission(self, request: Request, view) -> bool:
        if request.user.is_authenticated:
            return True
        return False

    def has_object_permission(self, request: Request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.author == request.user or request.user.is_staff
