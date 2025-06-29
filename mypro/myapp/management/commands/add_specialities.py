from django.core.management.base import BaseCommand
from myapp.models import service_tab, BASIC_SPECIALITIES

class Command(BaseCommand):
    help = 'Add basic dental specialities to the service_tab table.'

    def handle(self, *args, **options):
        added = 0
        for speciality in BASIC_SPECIALITIES:
            if not service_tab.objects.filter(service_type=speciality).exists():
                service_tab.objects.create(service_type=speciality)
                added += 1
        self.stdout.write(self.style.SUCCESS(f'Added {added} specialities to service_tab.')) 