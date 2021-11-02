import grequests
import time

urls = [
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/01',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/02',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/04',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/05',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/06',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/08',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/09',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/10',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/11',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/12',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/13',
    'https://geoconnex-us-xyw5el42eq-uc.a.run.app/ref/states/15'
]

def main():
    times = []
    for i in range(40):
        start_time = time.perf_counter()
        rs = (grequests.get(u) for u in urls)
        grequests.map(rs)
        times.append(time.perf_counter()-start_time)

    print(sum(times)/len(times))

if __name__ == "__main__":
    main()
