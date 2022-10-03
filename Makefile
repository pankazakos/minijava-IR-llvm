all: compile

compile:
	java -jar jtb132di.jar -te minijava.jj
	java -jar javacc5.jar minijava-jtb.jj
	javac Main.java

Folder = minijava-extra

SRC = $(Folder)/Add.java \
$(Folder)/ArrayTest.java \
$(Folder)/CallFromSuper.java \
$(Folder)/Classes.java \
$(Folder)/DerivedCall.java \
$(Folder)/Example1.java \
$(Folder)/FieldAndClassConflict.java \
$(Folder)/Main.java \
$(Folder)/ManyClasses.java \
$(Folder)/OutOfBounds.java \
$(Folder)/Overload2.java \
$(Folder)/ShadowBaseField.java \
$(Folder)/ShadowField.java \
$(Folder)/test06.java \
$(Folder)/test07.java \
$(Folder)/test15.java \
$(Folder)/test17.java \
$(Folder)/test20.java \
$(Folder)/test62.java \
$(Folder)/test73.java \
$(Folder)/test82.java \
$(Folder)/test93.java \
$(Folder)/test99.java \

runtests:
	java Main $(SRC)

SRC2 = minijava-extra/test82

clang:
	java Main $(SRC2).java
	clang $(SRC2).ll -o $(SRC2)
	./$(SRC2)

clang-only:
	clang $(SRC2).ll -o $(SRC2)
	./$(SRC2)

clean:
	find . -name \*.class -type f -delete