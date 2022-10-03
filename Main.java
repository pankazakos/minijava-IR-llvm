import syntaxtree.*;
import visitor.*;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;

import SymbolTable.SymbolTable;

public class Main {
    public static void main(String[] args) throws Exception {
        if(args.length == 0){
            System.err.println("Usage: java Main [file1] [file2] ... [fileN]");
            System.exit(1);
        }


        for(String argument : args){
            SymbolTable st;
            FileInputStream fis = null;
            try{
                fis = new FileInputStream(argument);
                MiniJavaParser parser = new MiniJavaParser(fis);
                Goal root = parser.Goal();
                System.err.println("Program parsed successfully.");

                st = new SymbolTable();

                //Call first visitor
                FirstVisitor evalfirst = new FirstVisitor(st);
                root.accept(evalfirst, null);
                System.out.println("file" + argument + ": Population of symbol table completed");

                //Call second visitor
                SecondVisitor second = new SecondVisitor(st);
                root.accept(second, null); 
                System.out.println("file" + argument + ": Type check completed. The file is semantically correct!");

                //Print offsets
                st.PrintOffsets();
                System.out.println();

                //Call visitor that generates Intermidiate code
                System.out.println("Generating LLVM code from Minijava...");
                IRVisitor irVisitor = new IRVisitor(st, argument);
                root.accept(irVisitor, null);
                System.out.println("Done");

                System.out.println("\n\n");
            }
            catch(ParseException ex){
                System.out.println(ex.getMessage());
            }
            catch(FileNotFoundException ex){
                System.err.println(ex.getMessage());
            }
            finally{
                try{
                    if(fis != null) fis.close();
                }
                catch(IOException ex){
                    System.err.println(ex.getMessage());
                }
            }
        }
    }
}
