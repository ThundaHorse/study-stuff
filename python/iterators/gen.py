def take(count, iterable):
    counter = 0
    for item in iterable:
        if counter == count:
            return
        counter += 1
        yield item


def run_take():
    items = [2, 4, 6, 8, 10]
    for item in take(3, items):
        print(item)


def distinct(iterable):
    seen = set()
    for item in iterable:
        if item in seen:
            continue
        yield item
        seen.add(item)


def run_distinct():
    items = [5, 7, 7, 6, 5, 5]
    for item in distinct(items):
        print(item)

# Arranging generators to form a lazy pipeline


def run_pipeline():
    items = [3, 6, 6, 2, 2, 1]
    for item in take(3, distinct(items)):
        print(item)


if __name__ == '__main__':
    #     run_take()
    #     run_distinct()
    run_pipeline()
