from django.http import JsonResponse
from django.shortcuts import render
def vue_index(request):
        return render(request, "vue_build/index.html")

def get_data(request):
    return JsonResponse([
        { "id": 1, "name": "Tofu", "level": "Hacker" },
        { "id": 2, "name": "Mr. Dick", "level": "Support" },
        { "id": 3, "name": "DildoKing", "level": "Cant live without him" },
    ], safe=False)

