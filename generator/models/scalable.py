from abc import abstractmethod


class Scalable:
    @abstractmethod
    def scale(self, factor: float):
        pass
