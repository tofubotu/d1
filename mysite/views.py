from django.http import JsonResponse
from django.shortcuts import render
def vue_index(request):
        return render(request, "vue_index.html")

def get_data(request):
    return JsonResponse([
        { "id": 1, "name": "Tofu", "level": "Hacker" },
        { "id": 2, "name": "Q", "level": "Support" },
    ], safe=False)

