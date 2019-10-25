'''
Code of a generic FSM.
Taken from the website https://www.python-course.eu/finite_state_machine.php
'''

class StateMachine:
    def __init__(self):
        self.handlers = {}
        self.startState = None
        self.endStates = []

    def add_state(self, name, handler, end_state=0):
        name = name.upper()
        self.handlers[name] = handler
        if end_state:
            self.endStates.append(name)

    def set_start(self, name):
        self.startState = name.upper()

    def run(self, cargo):
        try:
            handler = self.handlers[self.startState]
        except:
            raise Exception("must call .set_start() before .run()")
        if not self.endStates:
            raise  Exception("at least one state must be an end_state")
    
        while True:
            (newState, cargo) = handler(cargo)
            if newState.upper() in self.endStates:
                return True 
            else:
                handler = self.handlers[newState.upper()]  
