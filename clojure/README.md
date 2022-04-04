# clj-toy-robot

A Clojure implementation of the toy robot exercise 

Built on OS X 10.9.4 with Leiningen 2.3.4 on Java 1.7.0_45

## Usage

echo "PLACE 0,0,NORTH\nMOVE\nREPORT" | lein run -m clj-toy-robot.runner

or 

cat commands.txt | lein run -m clj-toy-robot.runner 

or just type the commands

lein run -m clj-toy-robot.runner

## Discussion

Really what I was aiming for was a simple implementation where you just reduce the 
input with a function.  This works well until you come to the REPORT command.

There are two types to represent the robot being on the table or not on the 
table. A protocol is used for a functional polymorphism.

Testing all the other functions was easy.  I considered capturing the output of
println and testing that.  But that didn't feel like the Clojure way.

Rather than just returning the new sate the commands could have returned the state with
the output; I guess that would be a Monad.  I would have preferred to have it work that way. 

