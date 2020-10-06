import django
import time


def main():
    while True:
        print(django.VERSION)
        time.sleep(3)


if __name__ == "__main__":
    main()
