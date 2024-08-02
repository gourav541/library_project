from django.shortcuts import render, redirect
from library_project import settings
from books.views.booksapi_views import fetch_random_books
    
# Create your views here.
def MainWebsite(request):
    # mission = AddOurMission.objects.values().first()
    # journeys = AddOurJourney.objects.all()

    books = fetch_random_books()
    


    context = {
        # 'MEDIA_URL':settings.MEDIA_URL,
        'books': books,  
        'error': not books,

    }
    return render(request,'website/index.html',context)


# Create your views here.
def BookDetails(request):
    # mission = AddOurMission.objects.values().first()
    # journeys = AddOurJourney.objects.all()



    context = {
        'MEDIA_URL':settings.MEDIA_URL,

    }
    return render(request,'website/bookDetails.html',context)