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
$(Folder)/test62.java \
$(Folder)/test73.java \
$(Folder)/test82.java \
$(Folder)/test99.java \
#$(Folder)/test17.java \
#$(Folder)/test20.java \
#$(Folder)/test93.java \

SRC2 = $(Folder)/Add.java \
$(Folder)/ArrayTest.java \
$(Folder)/CallFromSuper.java \
$(Folder)/Classes.java \
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
$(Folder)/test62.java \
$(Folder)/test82.java \
$(Folder)/test99.java \
#$(Folder)/DerivedCall.java \
#$(Folder)/test73.java \

runtests:
	java Main $(SRC)

clang-tests:
	java Main $(SRC)
	for i in $(SRC2); \
	do \
	    echo "clang: " $$i; \
	    clang $${i%.java}.ll -o $${i%.java}; \
	    ./$${i%.java}; \
	    echo "\n"; \
	done
	
clang-only:
	for i in $(SRC2); \
	do \
	    echo "clang: " $$i; \
	    clang $${i%.java}.ll -o $${i%.java}; \
	    ./$${i%.java}; \
	    echo "\n"; \
	done

Visitor = visitor

clean:
	find . -name \*.class -type f -delete
	rm -rf syntaxtree
	rm JavaCharStream.java MiniJavaParser.java MiniJavaParserConstants.java \
	MiniJavaParserTokenManager.java ParseException.java minijava-jtb.jj \
	Token.java TokenMgrError.java $(Visitor)/DepthFirstVisitor.java \
	$(Visitor)/GJDepthFirst.java $(Visitor)/GJNoArguDepthFirst.java \
	$(Visitor)/GJNoArguVisitor.java $(Visitor)/GJVisitor.java \
	$(Visitor)/GJVoidDepthFirst.java $(Visitor)/GJVoidVisitor.java \
	$(Visitor)/Visitor.java
