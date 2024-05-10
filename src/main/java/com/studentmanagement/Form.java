
package com.studentmanagement;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;


@WebServlet(urlPatterns =  "/Form")
public class Form extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    
    /**
     * @see HttpServlet#HttpServlet()
     */
	
    public Form() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	@Override 
	public void init() throws ServletException 
	{
		super.init();
		//System.out.print("init");
	}
	
	@Override 
	public void destroy() 
	{
		super.destroy(); 
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html") ;
		PrintWriter print = response.getWriter(); 
		print.println("<form action = 'StudentManagement' method = 'post'>");
		print.println("ten:<input type = 'text' name = 'ten'>");
		print.println("tuoi:<input type = 'text' name = 'tuoi'>");
		print.println("diachi:<input type = 'text' name = 'diachi'>");
		print.println("<input type = 'submit' value = 'submit'>");
		print.println("</form> ");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		
		PrintWriter write  = response.getWriter(); 
		String ten = request.getParameter("ten"); 
		String tuoi = request.getParameter("tuoi"); 
		String diachi = request.getParameter("diachi"); 
		write.println("Ten " + ten + "Tuoi " + tuoi + "Dia chi " + diachi);
		
		doGet(request, response);
	}

}
